create or replace PACKAGE to_3nf AS 
    PROCEDURE ext_to_wrk;
    PROCEDURE customers_3nf;
    PROCEDURE employees_3nf;
    PROCEDURE store_3nf;
    PROCEDURE product_3nf;
    PROCEDURE facts_3nf;
END to_3nf;


create or replace PACKAGE BODY to_3nf AS 
    PROCEDURE ext_to_wrk 
        IS
        BEGIN
            EXECUTE IMMEDIATE 'TRUNCATE TABLE wrk_customer';
            INSERT INTO wrk_customer SELECT * FROM src.src_customer;

            EXECUTE IMMEDIATE 'TRUNCATE TABLE wrk_employees';
            INSERT INTO wrk_employees SELECT src.*, TRUNC(DBMS_RANDOM.VALUE(0,20)) FROM src.src_employees src;

            EXECUTE IMMEDIATE 'TRUNCATE TABLE wrk_products';
            INSERT INTO wrk_products SELECT * FROM src.prod;

            EXECUTE IMMEDIATE 'TRUNCATE TABLE wrk_store';
            INSERT INTO wrk_store SELECT * FROM stores_src;
    END ext_to_wrk;

    PROCEDURE customers_3nf
    IS
    aft_ins INT;
    BEGIN

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_continents';
        INSERT INTO cl_continents(continent_name) SELECT DISTINCT continent_name FROM wrk_customer;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_regions';
        INSERT INTO cl_regions(region_name) SELECT DISTINCT region_name FROM wrk_customer;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_countries';
        INSERT INTO cl_countries(country_code, country_name) SELECT DISTINCT country_name, country_code FROM wrk_customer;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_cities';
        INSERT INTO cl_cities(city_name) SELECT DISTINCT city_name FROM wrk_customer;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_address';
        INSERT INTO cl_address(street, house, flat, phone) SELECT DISTINCT street, house, flat, phone FROM wrk_customer WHERE id < 1000;
        COMMIT;   

        INSERT INTO bl_3nf.continents(id_continent, continent_name)
            SELECT bl_3nf.continent_seq.nextval, con.continent_name 
            FROM cl_continents con 
            LEFT JOIN bl_3nf.continents cont
            ON con.continent_name = cont.continent_name
            WHERE cont.continent_name IS NULL
        LOG ERRORS INTO ERROR_CONTINENTS
        REJECT LIMIT UNLIMITED;
        COMMIT;

        INSERT INTO bl_3nf.regions(id_region, region_name, id_continent)
            SELECT bl_3nf.region_seq.nextval, reg.region_name, 
                (SELECT id_continent
                 FROM bl_3nf.continents con 
                 WHERE con.continent_name = 
                    (SELECT DISTINCT continent_name 
                     FROM wrk_customer 
                     WHERE con.continent_name = continent_name AND region_name = reg.region_name)
                )
            FROM cl_regions reg 
            LEFT JOIN bl_3nf.regions regt
            ON reg.region_name  = regt.region_name 
            WHERE regt.region_name IS NULL
        LOG ERRORS INTO ERROR_REGIONS
        REJECT LIMIT UNLIMITED;
        COMMIT;

       INSERT INTO bl_3nf.countries(id_country, country_name, country_code, id_region)
            SELECT bl_3nf.country_seq.nextval, cl_c.country_name, cl_c.country_code,
                (SELECT id_region
                 FROM bl_3nf.regions reg
                 WHERE reg.region_name = 
                    (SELECT DISTINCT region_name
                     FROM wrk_customer
                     WHERE reg.region_name = region_name AND country_code = cl_c.country_name)
                    )
            FROM cl_countries cl_c
            LEFT JOIN bl_3nf.countries bl_c
            ON bl_c.country_name = cl_c.country_name
            WHERE bl_c.country_name IS NULL
        LOG ERRORS INTO ERROR_COUNTRIES
        REJECT LIMIT UNLIMITED;
        COMMIT;     

        EXECUTE IMMEDIATE 'TRUNCATE TABLE ERROR_CITY';  
        INSERT INTO bl_3nf.cities(id_city, city_name, id_country)
            SELECT bl_3nf.city_seq.nextval, cl.city_name, 
                (SELECT DISTINCT id_country 
                 FROM bl_3nf.countries nf
                 JOIN wrk_customer wrk
                 ON nf.country_name = wrk.country_code AND wrk.city_name = cl.city_name)
            FROM cl_cities cl
            LEFT JOIN bl_3nf.cities cit
            ON cit.city_name = cl.city_name
            WHERE cit.city_name IS NULL
         LOG ERRORS INTO ERROR_CITY
         REJECT LIMIT UNLIMITED;
         SELECT COUNT(1) INTO aft_ins FROM ERROR_CITY;
         IF aft_ins > 0 THEN
            INSERT INTO bl_3nf.cities(id_city, city_name, id_country)
                SELECT bl_3nf.city_seq.nextval, a1.*
                FROM (
                    SELECT DISTINCT wrk.city_name, id_country
                    FROM wrk_customer wrk
                    JOIN bl_3nf.countries cl
                    ON wrk.country_code = cl.country_name 
                    WHERE city_name IN 
                        (SELECT CITY_NAME
                         FROM ERROR_CITY)
                ) a1
            LOG ERRORS INTO ERROR_CITY
            REJECT LIMIT UNLIMITED;   
         END IF;    
         COMMIT;

         INSERT INTO bl_3nf.address(id_address, street, house, flat, phone, city_id)
            SELECT bl_3nf.address_seq.nextval, cl_a.street, cl_a.house, cl_a.flat, cl_a.phone,
                (SELECT DISTINCT id_city
                 FROM (SELECT DISTINCT * 
                         FROM bl_3nf.cities ct 
                         JOIN bl_3nf.countries cn 
                         ON ct.id_country = cn.id_country) cl3
                 JOIN wrk_customer wrk
                 ON cl3.city_name = wrk.city_name AND cl3.country_name = wrk.country_code AND wrk.street = cl_a.street AND wrk.house = cl_a.house 
                 WHERE CASE
                    WHEN (wrk.flat = cl_a.flat)
                    THEN 1
                    WHEN wrk.flat IS NULL
                    THEN 1
                    ELSE 0
                    END > 0
                )
            FROM cl_address cl_a
            LEFT JOIN bl_3nf.address nf_a
            ON cl_a.street = nf_a.street AND cl_a.house = nf_a.house
            WHERE nf_a.street IS NULL
         LOG ERRORS INTO ERROR_ADDRESS
         REJECT LIMIT UNLIMITED;
         COMMIT;


        EXECUTE IMMEDIATE 'TRUNCATE TABLE CL_CUSTOMERS';

        INSERT INTO CL_CUSTOMERS (id_customer, first_name, last_name, mobile_phone, email, id_address, start_dt, end_dt)
        SELECT *
        FROM 
           (SELECT src.id, src.l_name, src.f_name, src.m_phone, src.e_mail,
                (SELECT DISTINCT id_address
                 FROM bl_3nf.address bl
                 JOIN wrk_customer wrk
                 ON bl.street = wrk.street AND bl.house = wrk.house AND src.id = wrk.id) id_address,
             NVL2(tgt.id_b, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt, TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
            FROM wrk_customer src 
            LEFT JOIN bl_3nf.customers tgt
            ON (tgt.start_dt<= TRUNC(sysdate) AND tgt.end_dt > TRUNC(sysdate) AND tgt.id_b = src.id)
            WHERE DECODE(src.l_name, tgt.first_name, 0,1) + DECODE(src.f_name, tgt.last_name, 0, 1) + DECODE(src.m_phone, tgt.mobile_phone, 0, 1) + DECODE(src.e_mail, tgt.email, 0, 1) > 0
            UNION ALL
            SELECT tgt.id_b, tgt.first_name, tgt.last_name, tgt.mobile_phone, tgt.email,
                (SELECT DISTINCT id_address
                 FROM bl_3nf.address bl
                 JOIN wrk_customer wrk
                 ON bl.street = wrk.street AND bl.house = wrk.house AND src.id = wrk.id) id_address,
                 tgt.start_dt, TRUNC(sysdate) end_dt
            FROM wrk_customer src
            JOIN bl_3nf.customers tgt
            ON (tgt.start_dt<= TRUNC(sysdate) AND tgt.end_dt > TRUNC(sysdate) AND tgt.id_b = src.id)
            WHERE DECODE(src.l_name, tgt.first_name, 0,1) + DECODE(src.f_name, tgt.last_name, 0, 1) + DECODE(src.m_phone, tgt.mobile_phone, 0, 1) + DECODE(src.e_mail, tgt.email, 0, 1) > 0
            )    
        WHERE ID < 100;

        MERGE INTO bl_3nf.customers tgt
        USING (SELECT * FROM CL_CUSTOMERS) src
        ON (src.id_customer = tgt.id_b 
        AND src.start_dt = tgt.start_dt)
        WHEN MATCHED THEN 
        UPDATE SET tgt.first_name = src.first_name, tgt.last_name = src.last_name, tgt.mobile_phone = src.mobile_phone, 
            tgt.email= src.email, tgt.end_dt = src.end_dt
        WHEN NOT MATCHED THEN 
        INSERT (id_customer, id_b, first_name, last_name, mobile_phone, email, id_address, start_dt, end_dt)
        VALUES (bl_3nf.customer_seq.nextval, src.id_customer, src.first_name, src.last_name, src.mobile_phone, src.email, src.id_address, src.start_dt, src.end_dt)
        LOG ERRORS INTO ERROR_CUSTOMERS
        REJECT LIMIT UNLIMITED;

        COMMIT;        

    END customers_3nf;



PROCEDURE employees_3nf
    IS
        aft_ins INT;
    BEGIN
     EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_continents';
        INSERT INTO cl_continents(continent_name) SELECT DISTINCT continent_name FROM wrk_employees;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_regions';
        INSERT INTO cl_regions(region_name) SELECT DISTINCT region_name FROM wrk_employees;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_countries';
        INSERT INTO cl_countries(country_name, country_code) SELECT DISTINCT country_name, country_code FROM wrk_employees;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_cities';
        INSERT INTO cl_cities(city_name) SELECT DISTINCT city_name FROM wrk_employees;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_address';
        INSERT INTO cl_address(street, house, flat, phone) SELECT DISTINCT street, house, flat, phone FROM wrk_employees;
        COMMIT;  

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_jobs';
        INSERT INTO cl_jobs(job_name) SELECT DISTINCT jobs FROM wrk_employees;
        COMMIT; 

        INSERT INTO bl_3nf.continents(id_continent, continent_name)
            SELECT bl_3nf.continent_seq.nextval, con.continent_name 
            FROM cl_continents con 
            LEFT JOIN bl_3nf.continents cont
            ON con.continent_name = cont.continent_name
            WHERE cont.continent_name IS NULL
        LOG ERRORS INTO ERROR_CONTINENTS
        REJECT LIMIT UNLIMITED;
        COMMIT;

        INSERT INTO bl_3nf.regions(id_region, region_name, id_continent)
            SELECT bl_3nf.region_seq.nextval, reg.region_name, 
                (SELECT id_continent
                 FROM bl_3nf.continents con 
                 WHERE con.continent_name = 
                    (SELECT DISTINCT continent_name 
                     FROM wrk_employees 
                     WHERE con.continent_name = continent_name AND region_name = reg.region_name)
                )
            FROM cl_regions reg 
            LEFT JOIN bl_3nf.regions regt
            ON reg.region_name  = regt.region_name 
            WHERE regt.region_name IS NULL
        LOG ERRORS INTO ERROR_REGIONS
        REJECT LIMIT UNLIMITED;
        COMMIT;

       INSERT INTO bl_3nf.countries(id_country, country_name, country_code, id_region)
            SELECT bl_3nf.country_seq.nextval, cl_c.country_name, cl_c.country_code,
                (SELECT id_region
                 FROM bl_3nf.regions reg
                 WHERE reg.region_name = 
                    (SELECT DISTINCT region_name
                     FROM wrk_employees
                     WHERE reg.region_name = region_name AND country_code = cl_c.country_name)
                    )
            FROM cl_countries cl_c
            LEFT JOIN bl_3nf.countries bl_c
            ON bl_c.country_name = cl_c.country_name
            WHERE bl_c.country_name IS NULL
        LOG ERRORS INTO ERROR_COUNTRIES
        REJECT LIMIT UNLIMITED;
        COMMIT;     

        INSERT INTO bl_3nf.cities(id_city, city_name, id_country)
            SELECT bl_3nf.city_seq.nextval, cl.city_name, 
                (SELECT DISTINCT id_country 
                 FROM bl_3nf.countries nf
                 JOIN wrk_employees wrk
                 ON nf.country_name = wrk.country_code AND wrk.city_name = cl.city_name)
            FROM cl_cities cl
            LEFT JOIN bl_3nf.cities cit
            ON cit.city_name = cl.city_name
            WHERE cit.city_name IS NULL
         LOG ERRORS INTO ERROR_CITY
         REJECT LIMIT UNLIMITED;
         SELECT COUNT(1) INTO aft_ins FROM ERROR_CITY;
         IF aft_ins > 0 THEN
            INSERT INTO bl_3nf.cities(id_city, city_name, id_country)
                SELECT bl_3nf.city_seq.nextval, a1.*
                FROM (
                    SELECT DISTINCT wrk.city_name, id_country
                    FROM wrk_employees wrk
                    JOIN bl_3nf.countries cl
                    ON wrk.country_code = cl.country_name 
                    WHERE city_name IN 
                        (SELECT CITY_NAME
                         FROM ERROR_CITY)
                ) a1
            LOG ERRORS INTO ERROR_CITY
            REJECT LIMIT UNLIMITED;   
         END IF;    
         COMMIT;

         INSERT INTO bl_3nf.address(id_address, street, house, flat, phone, city_id)
            SELECT bl_3nf.address_seq.nextval, cl_a.street, cl_a.house, cl_a.flat, cl_a.phone,
                (SELECT DISTINCT id_city
                 FROM (SELECT DISTINCT * 
                         FROM bl_3nf.cities ct 
                         JOIN bl_3nf.countries cn 
                         ON ct.id_country = cn.id_country) cl3
                 JOIN wrk_employees wrk
                 ON cl3.city_name = wrk.city_name AND cl3.country_name = wrk.country_name AND wrk.street = cl_a.street AND wrk.house = cl_a.house 
                 WHERE CASE
                    WHEN (wrk.flat = cl_a.flat)
                    THEN 1
                    WHEN wrk.flat IS NULL
                    THEN 1
                    ELSE 0
                    END > 0
                )
            FROM cl_address cl_a
            LEFT JOIN bl_3nf.address nf_a
            ON cl_a.street = nf_a.street AND cl_a.house = nf_a.house
            WHERE nf_a.street IS NULL
         LOG ERRORS INTO ERROR_ADDRESS
         REJECT LIMIT UNLIMITED;
         COMMIT; 

         INSERT INTO bl_3nf.jobs(id_jobs, job_name)
            SELECT bl_3nf.jobs_seq.nextval, cl.job_name 
            FROM cl_jobs cl
            LEFT JOIN bl_3nf.jobs nf
            ON cl.job_name = nf.job_name
            WHERE nf.id_jobs IS NULL
        LOG ERRORS INTO ERROR_JOBS
        REJECT LIMIT UNLIMITED;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE CL_EMPLOYEES';

        INSERT INTO  cl_employees (id_employee, first_name, last_name, mobile_phone, email, id_job, salary, id_address, start_dt, end_dt)
        SELECT src.id, src.first_name, src.last_name, src.m_phone, src.email,
                (SELECT id_jobs
                 FROM bl_3nf.jobs jb
                 WHERE jb.job_name = src.jobs) id_job,
                 src.salary,
                (SELECT DISTINCT id_address
                 FROM bl_3nf.address bl
                 JOIN wrk_employees wrk
                 ON bl.street = wrk.street AND bl.house = wrk.house AND src.id = wrk.id) id_address,
             NVL2(tgt.id_employee, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt, TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
            FROM wrk_employees src 
            LEFT JOIN bl_3nf.employees tgt
            ON (tgt.start_dt<= TRUNC(sysdate) AND tgt.end_dt > TRUNC(sysdate) AND tgt.id_employee = src.id)
            WHERE DECODE(src.first_name, tgt.first_name, 0,1) + DECODE(src.last_name, tgt.last_name, 0, 1) + DECODE(src.m_phone, tgt.mobile_phone, 0, 1) + DECODE(src.email, tgt.email, 0, 1) > 0
            UNION ALL
            SELECT tgt.id_employee, tgt.first_name, tgt.last_name, tgt.mobile_phone, tgt.email,
                (SELECT id_jobs
                 FROM bl_3nf.jobs jb
                 WHERE jb.job_name = src.jobs) id_job,
                 tgt.salary,
               (SELECT DISTINCT id_address
                 FROM bl_3nf.address bl
                 JOIN wrk_employees wrk
                 ON bl.street = wrk.street AND bl.house = wrk.house AND src.id = wrk.id) id_address,
                 tgt.start_dt, TRUNC(sysdate) end_dt
            FROM wrk_employees src
            JOIN bl_3nf.employees tgt
            ON (tgt.start_dt<= TRUNC(sysdate) AND tgt.end_dt > TRUNC(sysdate) AND tgt.id_employee = src.id)
            WHERE DECODE(src.first_name, tgt.first_name, 0,1) + DECODE(src.last_name, tgt.last_name, 0, 1) + DECODE(src.m_phone, tgt.mobile_phone, 0, 1) + DECODE(src.email, tgt.email, 0, 1) > 0;

            MERGE INTO bl_3nf.employees tgt
            USING (SELECT * FROM cl_employees) src
            ON (src.id_employee = tgt.id_employee
            AND src.start_dt = tgt.start_dt)
            WHEN MATCHED THEN 
            UPDATE SET tgt.first_name = src.first_name, tgt.last_name = src.last_name, tgt.mobile_phone = src.mobile_phone, 
                tgt.email= src.email, tgt.end_dt = src.end_dt, tgt.id_store = src.id_story, tgt.id_job = src.id_job, tgt.manager_id = src.manager_id,
                tgt.id_address = src.id_address, tgt.salary = src.salary
            WHEN NOT MATCHED THEN 
            INSERT (id_emp, id_employee, first_name, last_name, mobile_phone, email, id_address, start_dt, end_dt, salary, id_job)
            VALUES (bl_3nf.employee_seq.nextval, src.id_employee, src.first_name, src.last_name, src.mobile_phone, src.email, src.id_address, src.start_dt, src.end_dt, src.salary, src.id_job)
            LOG ERRORS INTO ERROR_EMPLOYEES
            REJECT LIMIT UNLIMITED;

            COMMIT;
        END employees_3nf;


PROCEDURE store_3nf
    IS
        aft_ins INT;
        CURSOR insert_stores IS
            SELECT cl.*
            FROM cl_stores cl
            LEFT JOIN bl_3nf.stores nf
            ON cl.id_stores = nf.store_key
            WHERE nf.id_stores IS NULL;
        ins insert_stores%ROWTYPE;
    BEGIN
     EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_continents';
        INSERT INTO cl_continents(continent_name) SELECT DISTINCT continent FROM wrk_store;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_regions';
        INSERT INTO cl_regions(region_name) SELECT DISTINCT region FROM wrk_store;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_countries';
        INSERT INTO cl_countries(country_name) SELECT DISTINCT country FROM wrk_store;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_cities';
        INSERT INTO cl_cities(city_name) SELECT DISTINCT city FROM wrk_store;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_address';
        INSERT INTO cl_address(street, house, flat, phone) SELECT DISTINCT street, house, flat, phone FROM wrk_store;
        COMMIT;  


        INSERT INTO bl_3nf.continents(id_continent, continent_name)
            SELECT bl_3nf.continent_seq.nextval, con.continent_name 
            FROM cl_continents con 
            LEFT JOIN bl_3nf.continents cont
            ON con.continent_name = cont.continent_name
            WHERE cont.continent_name IS NULL
        LOG ERRORS INTO ERROR_CONTINENTS
        REJECT LIMIT UNLIMITED;
        COMMIT;

        INSERT INTO bl_3nf.regions(id_region, region_name, id_continent)
            SELECT bl_3nf.region_seq.nextval, reg.region_name, 
                (SELECT id_continent
                 FROM bl_3nf.continents con 
                 WHERE con.continent_name = 
                    (SELECT DISTINCT continent_name 
                     FROM wrk_store 
                     WHERE con.continent_name = continent AND region = reg.region_name)
                )
            FROM cl_regions reg 
            LEFT JOIN bl_3nf.regions regt
            ON reg.region_name  = regt.region_name 
            WHERE regt.region_name IS NULL
        LOG ERRORS INTO ERROR_REGIONS
        REJECT LIMIT UNLIMITED;
        COMMIT;

       INSERT INTO bl_3nf.countries(id_country, country_name, country_code, id_region)
            SELECT bl_3nf.country_seq.nextval, cl_c.country_name, cl_c.country_code,
                (SELECT id_region
                 FROM bl_3nf.regions reg
                 WHERE reg.region_name = 
                    (SELECT DISTINCT region_name
                     FROM wrk_store
                     WHERE reg.region_name = region AND country = cl_c.country_name)
                    )
            FROM cl_countries cl_c
            LEFT JOIN bl_3nf.countries bl_c
            ON bl_c.country_name = cl_c.country_name
            WHERE bl_c.country_name IS NULL
        LOG ERRORS INTO ERROR_COUNTRIES
        REJECT LIMIT UNLIMITED;
        COMMIT;     

        INSERT INTO bl_3nf.cities(id_city, city_name, id_country)
            SELECT bl_3nf.city_seq.nextval, cl.city_name, 
                (SELECT DISTINCT id_country 
                 FROM bl_3nf.countries nf
                 JOIN wrk_store wrk
                 ON nf.country_name = wrk.country AND wrk.city = cl.city_name)
            FROM cl_cities cl
            LEFT JOIN bl_3nf.cities cit
            ON cit.city_name = cl.city_name
            WHERE cit.city_name IS NULL
         LOG ERRORS INTO ERROR_CITY
         REJECT LIMIT UNLIMITED;
         SELECT COUNT(1) INTO aft_ins FROM ERROR_CITY;
         IF aft_ins > 0 THEN
            INSERT INTO bl_3nf.cities(id_city, city_name, id_country)
                SELECT bl_3nf.city_seq.nextval, a1.*
                FROM (
                    SELECT DISTINCT wrk.city, id_country
                    FROM wrk_store wrk
                    JOIN bl_3nf.countries cl
                    ON wrk.country = cl.country_name 
                    WHERE city IN 
                        (SELECT CITY_NAME
                         FROM ERROR_CITY)
                ) a1
            LOG ERRORS INTO ERROR_CITY
            REJECT LIMIT UNLIMITED;   
         END IF;    
         COMMIT;

         INSERT INTO bl_3nf.address(id_address, street, house, flat, phone, city_id)
            SELECT bl_3nf.address_seq.nextval, cl_a.street, cl_a.house, cl_a.flat, cl_a.phone,
                (SELECT DISTINCT id_city
                 FROM (SELECT DISTINCT * 
                         FROM bl_3nf.cities ct 
                         JOIN bl_3nf.countries cn 
                         ON ct.id_country = cn.id_country) cl3
                 JOIN wrk_store wrk
                 ON cl3.city_name = wrk.city AND cl3.country_name = wrk.country AND wrk.street = cl_a.street AND wrk.house = cl_a.house 
                 WHERE CASE
                    WHEN (wrk.flat = cl_a.flat)
                    THEN 1
                    WHEN wrk.flat IS NULL
                    THEN 1
                    ELSE 0
                    END > 0
                )
            FROM cl_address cl_a
            LEFT JOIN bl_3nf.address nf_a
            ON cl_a.street = nf_a.street AND cl_a.house = nf_a.house
            WHERE nf_a.street IS NULL
         LOG ERRORS INTO ERROR_ADDRESS
         REJECT LIMIT UNLIMITED;
         COMMIT; 


         EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_stores';
         INSERT INTO cl_stores(id_stores, stores_desc, id_address, id_managaer)      
            SELECT wrk.id_store, wrk.store_desc, nf.id_address, 
                (SELECT id_emp
                 FROM bl_3nf.employees emp
                 WHERE wrk.id_manager = emp.id_employee)
            FROM wrk_store wrk
            JOIN bl_3nf.address nf
            ON wrk.street = nf.street AND wrk.house = nf.house
            WHERE CASE
                    WHEN (wrk.flat = nf.flat)
                    THEN 1
                    WHEN wrk.flat IS NULL
                    THEN 1
                    ELSE 0
                    END > 0;
        COMMIT;

        OPEN insert_stores;
        LOOP
            FETCH insert_stores INTO ins;
            EXIT WHEN insert_stores%NOTFOUND;

            INSERT INTO bl_3nf.stores (id_stores, store_key, stores_desc, id_address, id_managaer)
            VALUES(bl_3nf.store_seq.nextval, ins.id_stores, ins.stores_desc, ins.id_address, ins.id_managaer);

        END LOOP;

        CLOSE insert_stores;

        FOR upd IN (SELECT * FROM bl_3nf.employees)
        LOOP
            UPDATE bl_3nf.employees 
            SET id_store = 
                (SELECT DISTINCT nf.id_stores
                 FROM bl_3nf.stores nf
                 JOIN wrk_employees wrk
                 ON nf.store_key = wrk.store_id+1 AND wrk.id = upd.id_employee)
            WHERE id_emp = upd.id_emp
            LOG ERRORS INTO ERROR_EMPLOYEES
            REJECT LIMIT UNLIMITED;
        END LOOP;
        COMMIT;
    END store_3nf;       


PROCEDURE product_3nf
    IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_category';
        INSERT INTO cl_category(category_name, category_desc) SELECT DISTINCT category, nvl(category_desc, '-') FROM wrk_products;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_subcategory';
        INSERT INTO cl_subcategory(subcategory_name, subcategory_desc) SELECT DISTINCT subcategory,  nvl(subcategory_desc, '-') FROM wrk_products;
        COMMIT;

        EXECUTE IMMEDIATE 'TRUNCATE TABLE cl_products';
        INSERT INTO cl_products(id_product, prod_name, prod_desc, prod_cost) SELECT DISTINCT id_prod, prod_name, nvl(prod_desc, '-'), prod_cost FROM wrk_products;
        COMMIT;  

        INSERT INTO bl_3nf.category (id_category, category_name, category_desc)
            SELECT bl_3nf.cat_seq.nextval , cl.category_name, cl.category_desc 
            FROM cl_category cl
            LEFT JOIN bl_3nf.category nf
            ON cl.category_name = nf.category_name
            WHERE nf.id_category IS NULL
        LOG ERRORS INTO ERROR_CATEGORY 
        REJECT LIMIT UNLIMITED;

        COMMIT;


        INSERT INTO bl_3nf.subcategory (id_subcategory, subcategory_name, subcategory_desc, id_category)
             SELECT bl_3nf.subcat_seq.nextval, cl.subcategory_name, cl.subcategory_desc ,
                 (SELECT DISTINCT id_category
                  FROM bl_3nf.category cat
                  JOIN wrk_products wrk
                  ON wrk.category = cat.category_name AND cl.subcategory_name = wrk.subcategory)
            FROM cl_subcategory cl
            LEFT JOIN bl_3nf.subcategory nf
            ON cl.subcategory_name = nf.subcategory_name
            WHERE nf.id_subcategory IS NULL
        LOG ERRORS INTO ERROR_SUBCATEGORY 
        REJECT LIMIT UNLIMITED;

        COMMIT;



        INSERT INTO bl_3nf.products (id_product, product_key, product_name, product_desc, prod_cost, id_subcategory)
             SELECT bl_3nf.prod_seq.nextval, cl.id_product, cl.prod_name, cl.prod_desc, cl.prod_cost,
                 (SELECT DISTINCT id_subcategory
                  FROM 
                    (SELECT * 
                     FROM bl_3nf.subcategory bl
                     JOIN bl_3nf.category ca
                     ON bl.id_category = ca.id_category) sc
                  JOIN wrk_products wrk
                  ON wrk.subcategory = sc.subcategory_name AND wrk.category= sc.category_name AND cl.prod_name = wrk.prod_name)
            FROM cl_products cl
            LEFT JOIN bl_3nf.products nf
            ON cl.id_product = nf.product_key
            WHERE nf.id_subcategory IS NULL
        LOG ERRORS INTO ERROR_PRODUCTS 
        REJECT LIMIT UNLIMITED;

        COMMIT;
    END product_3nf;


PROCEDURE facts_3nf
    IS
    BEGIN
        INSERT INTO bl_3nf.sales(id_sales, sales_key, id_customer, id_employee, id_store, date_sales, time_sales)
            SELECT bl_3nf.sales_seq.nextval, t.*
            FROM 
                (SELECT id_sales, 
                    CASE
                      WHEN (SELECT id_customer
                         FROM bl_3nf.customers nf_c
                         WHERE cl.id_customer = nf_c.id_b ) IS NULL
                         THEN -99
                      ELSE 
                        (SELECT id_customer
                         FROM bl_3nf.customers nf_c
                         WHERE cl.id_customer = nf_c.id_b)
                    END,
                    (SELECT id_employee
                     FROM bl_3nf.employees nf_e
                     WHERE cl.id_employee = nf_e.id_employee),
                    (SELECT id_stores
                     FROM bl_3nf.stores nf_s
                     WHERE cl.id_store = nf_s.store_key),
                    date_sales, time_sales
                 FROM cl_sales cl
                 MINUS
                 SELECT sales_key, id_customer, id_employee, id_store, date_sales, time_sales
                 FROM bl_3nf.sales nf
                 ) t
        LOG ERRORS INTO ERROR_SALES
        REJECT LIMIT UNLIMITED;

        COMMIT;

        INSERT INTO bl_3nf.payments(id_payment, payment_key, id_sales, id_product, amount)
            SELECT bl_3nf.payment_seq.nextval, t.*
            FROM
                (SELECT id_payment, nf_s.id_sales,
                    (SELECT id_product
                     FROM bl_3nf.products nf_p
                     WHERE nf_p.product_key = cl.id_product), amount
                FROM cl_payments cl
                JOIN bl_3nf.sales nf_s
                ON cl.id_sales = nf_s.sales_key
                MINUS 
                SELECT payment_key, id_sales, id_product, amount
                FROM bl_3nf.payments
                ) t
        LOG ERRORS INTO ERROR_PAYMENTS
        REJECT LIMIT UNLIMITED;

        COMMIT;




    END facts_3nf;

END to_3nf;
