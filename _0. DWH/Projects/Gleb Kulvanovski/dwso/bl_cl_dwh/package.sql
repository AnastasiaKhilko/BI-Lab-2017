create or replace PACKAGE nf_to_dwh 
AS
    PROCEDURE customer_dwh;
    PROCEDURE employee_dwh;
    PROCEDURE stores_dwh;
    PROCEDURE products_dwh;
    PROCEDURE date_dwh(Table_Name VARCHAR2, Start_date DATE, End_Date DATE, FlagDel BOOLEAN);
    PROCEDURE fact_dwh;
END nf_to_dwh;


create or replace PACKAGE BODY nf_to_dwh
AS
PROCEDURE customer_dwh
    IS
    BEGIN

        EXECUTE IMMEDIATE 'TRUNCATE TABLE BL_DWH_CUSTOMERS';

        INSERT INTO  bl_dwh_customers (id_customer, first_name, last_name, mobile_phone, address, location, start_dt, end_dt)
                SELECT id_customer, first_name, last_name, mobile_phone, street || ', ' || house || decode(flat, null, null, ('/' || flat)) || ', ' || phone AS address, 
                       city_name || ', ' || country_name || ', ' || region_name || ', ' || continent_name AS location, start_dt, end_dt
                FROM bl_3nf.customers cus
                JOIN bl_3nf.address ad
                ON cus.id_address = ad.id_address
                JOIN bl_3nf.cities cit
                ON ad.city_id = cit.id_city
                JOIN bl_3nf.countries cou
                ON cit.id_country = cou.id_country
                JOIN bl_3nf.regions reg
                ON cou.id_region = reg.id_region
                JOIN bl_3nf.continents con 
                ON reg.id_continent = con.id_continent
                MINUS
                SELECT customer_key, first_name, last_name, mobile_phone, address, location, start_dt, end_dt
                FROM dwh.customers;


            MERGE INTO dwh.customers tgt
            USING (SELECT * FROM bl_dwh_customers) src
            ON (src.id_customer = tgt.customer_key
            AND src.start_dt = tgt.start_dt)
            WHEN MATCHED THEN 
            UPDATE SET tgt.first_name = src.first_name, tgt.last_name = src.last_name, tgt.mobile_phone = src.mobile_phone,
                tgt.address = src.address, tgt.location = src.location, tgt.end_dt = src.end_dt
            WHEN NOT MATCHED THEN 
            INSERT (id_customer, customer_key, first_name, last_name, mobile_phone, address, location, start_dt, end_dt)
            VALUES (decode(src.id_customer, -99, -99, dwh.cust_seq.nextval), src.id_customer, src.first_name, src.last_name, src.mobile_phone, src.address, src.location, src.start_dt, src.end_dt)
            LOG ERRORS INTO ERROR_CUSTOMER
            REJECT LIMIT UNLIMITED;

            COMMIT;

    END customer_dwh;

PROCEDURE employee_dwh
    IS
    BEGIN
            EXECUTE IMMEDIATE 'TRUNCATE TABLE BL_DWH_EMPLOYEES';

            INSERT INTO  bl_dwh_employees (id_employee, first_name, last_name, job_name, salary, manager_id, mobile_phone, address, location, start_dt, end_dt)
                SELECT id_emp, first_name, last_name, job_name, salary, manager_id, mobile_phone, street || ', ' || house || decode(flat, null, null, ('/' || flat)) || ', ' || phone AS address, 
                       city_name || ', ' || country_name || ', ' || region_name || ', ' || continent_name AS location, start_dt, end_dt
                FROM bl_3nf.employees emp
                JOIN bl_3nf.address ad
                ON emp.id_address = ad.id_address
                JOIN bl_3nf.cities cit
                ON ad.city_id = cit.id_city
                JOIN bl_3nf.countries cou
                ON cit.id_country = cou.id_country
                JOIN bl_3nf.regions reg
                ON cou.id_region = reg.id_region
                JOIN bl_3nf.continents con 
                ON reg.id_continent = con.id_continent
                JOIN bl_3nf.jobs jb
                ON emp.id_job = jb.id_jobs
                MINUS
                SELECT employee_key, first_name, last_name, job_name, salary, manager_id, mobile_phone, address, location, start_dt, end_dt
                FROM dwh.employees;


            MERGE INTO dwh.employees tgt
            USING (SELECT * FROM bl_dwh_employees) src
            ON (src.id_employee = tgt.employee_key
            AND src.start_dt = tgt.start_dt)
            WHEN MATCHED THEN 
            UPDATE SET tgt.first_name = src.first_name, tgt.last_name = src.last_name, tgt.mobile_phone = src.mobile_phone, tgt.salary = src.salary, tgt.manager_id = src.manager_id, 
                tgt.address = src.address, tgt.location = src.location, tgt.end_dt = src.end_dt
            WHEN NOT MATCHED THEN 
            INSERT (id_employee, employee_key, first_name, last_name, job_name, salary, manager_id, mobile_phone, address, location, start_dt, end_dt)
            VALUES (decode(src.id_employee, -99, -99, dwh.emp_seq.nextval), src.id_employee, src.first_name, src.last_name, src.job_name, src.salary, nvl(src.manager_id, -99), src.mobile_phone, src.address,
                    src.location, src.start_dt, src.end_dt)
            LOG ERRORS INTO ERROR_EMPLOYEE
            REJECT LIMIT UNLIMITED;

            COMMIT;

    END employee_dwh;

PROCEDURE stores_dwh
     IS
     BEGIN

            EXECUTE IMMEDIATE 'TRUNCATE TABLE BL_DWH_STORES';

            INSERT INTO bl_dwh_stores (id_store, store_desc, phone, address, location, id_manager, manager_name)
                SELECT id_stores, nvl(stores_desc, ' '), phone,  street || ', ' || house || decode(flat, null, null, ('/' || flat)) AS address, 
                       city_name || ', ' || country_name || ', ' || region_name || ', ' || continent_name AS location, nvl(id_employee, -99), first_name || ' ' || last_name AS manager_name
                FROM bl_3nf.stores st
                JOIN bl_3nf.address ad
                ON st.id_address = ad.id_address
                JOIN bl_3nf.cities cit
                ON ad.city_id = cit.id_city
                JOIN bl_3nf.countries cou
                ON cit.id_country = cou.id_country
                JOIN bl_3nf.regions reg
                ON cou.id_region = reg.id_region
                JOIN bl_3nf.continents con 
                ON reg.id_continent = con.id_continent
                LEFT JOIN dwh.employees emp
                ON st.id_managaer = emp.employee_key
                MINUS
                SELECT store_key, store_desc, phone, address, location, id_manager, manager_name
                FROM dwh.stores;


                INSERT INTO dwh.stores (id_store, store_key, store_desc, phone, address, location, id_manager, manager_name)
                    SELECT dwh.store_seq.nextval, id_store, store_desc, phone, address, location, id_manager, manager_name
                    FROM bl_dwh_stores 
                LOG ERRORS INTO ERROR_STORE
                REJECT LIMIT UNLIMITED;

                COMMIT;

    END stores_dwh;


PROCEDURE products_dwh
    IS
    BEGIN

        EXECUTE IMMEDIATE 'TRUNCATE TABLE BL_DWH_PRODUCTS';

        INSERT INTO dwh.products(id_product, product_key, product_name, product_cost, subcategory_name, category_name, product_desc, subcategory_desc, category_desc)
                SELECT dwh.prod_seq.nextval, t.*
                FROM   
                    (SELECT id_product, product_name, prod_cost, subcategory_name, category_name, product_desc, subcategory_desc, category_desc 
                    FROM bl_3nf.products prod
                    JOIN bl_3nf.subcategory subc
                    ON prod.id_subcategory = subc.id_subcategory
                    JOIN bl_3nf.category cat
                    ON subc.id_category = cat.id_category
                    MINUS
                    SELECT product_key, product_name, product_cost, subcategory_name, category_name, product_desc, subcategory_desc, category_desc 
                    FROM dwh.products) t
        LOG ERRORS INTO ERROR_PRODUCT
        REJECT LIMIT UNLIMITED; 

        COMMIT;
    END products_dwh;

PROCEDURE date_dwh (Table_Name VARCHAR2, Start_date DATE, End_Date DATE, FlagDel BOOLEAN)
    IS
      T_Name VARCHAR2(30) := Table_Name;
      S_Date DATE := Start_Date;
      E_Date DATE := End_Date;
      cnt INT := 0;
      cnt_days NUMBER(10) := to_number(E_Date-S_Date);
      F_Del BOOLEAN := FlagDel;
      iExist INT;
      date_id DATE;
      day_d NUMBER(2);
      month_d NUMBER(2);
      year_d NUMBER(4);
      Day_y NUMBER(3);
      Day_w NUMBER(1);
      wy NUMBER(2);
      wm NUMBER(1);
      quat NUMBER(1);
      e_d VARCHAR2(15);
      r_d VARCHAR2(25);
      s_d VARCHAR2(15);
      g_d VARCHAR2(15);
      e_m VARCHAR2(15);
      r_m VARCHAR2(25);
      s_m VARCHAR2(15);
      g_m VARCHAR2(15);   
      not_table EXCEPTION;
      PRAGMA EXCEPTION_INIT(not_table, -00942);
    BEGIN
      IF(S_Date>=E_DATE)
      THEN 
        RAISE_APPLICATION_ERROR(-20001, 'End date > start date');
      END IF;
      SELECT COUNT(1) INTO iExist FROM User_Tables WHERE TABLE_NAME = UPPER(SUBSTR(T_Name, INSTR(T_Name, '.')+1));
      IF (iExist > 0 AND F_Del = FALSE)
      THEN
        RAISE_APPLICATION_ERROR (-20002, 'Table exist');
      ELSIF (iExist > 0 AND F_Del)
      THEN
        EXECUTE IMMEDIATE ('DROP TABLE ' || T_Name);
      END IF;
          EXECUTE IMMEDIATE ('CREATE TABLE ' || T_Name || ' ( Date_id DATE PRIMARY KEY, Day NUMBER(2) NOT NULL, Month NUMBER(2) NOT NULL, Year NUMBER(4), Day_Of_Year NUMBER(3) NOT NULL,
            Day_Of_Week NUMBER(1) NOT NULL, Week_Of_Year NUMBER(2) NOT NULL, Week_Of_Month NUMBER(1) NOT NULL, Quarter NUMBER(1) NOT NULL,
            English_Day_Of_Month VARCHAR2(15) NOT NULL, Russian_Day_Of_Month VARCHAR2(25) NOT NULL, Spanish_Day_Of_Month VARCHAR2(15) NOT NULL, German_Day_Of_Month VARCHAR2(15) NOT NULL,
            English_Month_Name VARCHAR2(15) NOT NULL, Russina_Month_Name VARCHAR2(25) NOT NULL, Spanish_Month_Name VARCHAR2(15) NOT NULL, German_Month_Name VARCHAR2(15) NOT NULL)');
      FOR cnt IN 0..cnt_days LOOP
      date_id := (s_date + cnt);
      day_d := extract(day from S_Date+cnt);
      month_d :=  extract(month from S_Date+cnt);
      year_d  := extract(year from S_Date+cnt);
      Day_y := to_number(to_char(S_Date+cnt, 'DDD'));
      Day_w  := to_number(to_char(S_Date+cnt-1, 'D'));
      wy  := to_number(to_char(S_Date+cnt, 'IW'));
      wm  := to_number(to_char(S_Date+cnt, 'W'));
      quat  := to_number(to_char(S_Date+cnt, 'Q'));
      e_d  := to_char(S_Date+cnt, 'DAY', 'NLS_DATE_LANGUAGE=ENGLISH');
      r_d  := to_char(S_Date+cnt, 'DAY', 'NLS_DATE_LANGUAGE=RUSSIAN');
      s_d := to_char(S_Date+cnt, 'DAY', 'NLS_DATE_LANGUAGE=SPANISH');
      g_d := to_char(S_Date+cnt, 'DAY', 'NLS_DATE_LANGUAGE=GERMAN');
      e_m := to_char(S_Date+cnt, 'MONTH', 'NLS_DATE_LANGUAGE=ENGLISH');
      r_m := to_char(S_Date+cnt, 'MONTH', 'NLS_DATE_LANGUAGE=RUSSIAN');
      s_m := to_char(S_Date+cnt, 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH');
      g_m := to_char(S_Date+cnt, 'MONTH', 'NLS_DATE_LANGUAGE=GERMAN');
      EXECUTE IMMEDIATE 'INSERT INTO ' || T_Name || '(Date_id, Day, Month, Year, Day_Of_Year, Day_Of_Week, Week_Of_Year, Week_Of_Month, Quarter, English_Day_Of_Month, Russian_Day_Of_Month,
        Spanish_Day_Of_Month, German_Day_Of_Month, English_Month_Name, Russina_Month_Name, Spanish_Month_Name, German_Month_Name)  VALUES(:b1, :b2, :b3, :b4, :b5, :b6, :b7, :b8,  :b9,
         :b10, :b11, :b12, :b13, :b14,  :b15, :b16, :b17)' USING date_id, day_d, month_d, year_d, day_y, Day_w, wy, wm, quat, e_d, r_d, s_d, g_d, e_m, r_m, s_m, g_m;
        END LOOP;
      COMMIT;
    EXCEPTION
     WHEN not_table THEN
        RAISE_APPLICATION_ERROR(-20003, 'Invalid table name');
    END date_dwh;     


PROCEDURE fact_dwh
    IS
    BEGIN

        INSERT INTO dwh.factsales (id_sales, sales_key, id_customer, id_employee, id_store, id_product, id_date, time_sale, amount)
            SELECT dwh.fact_seq.nextval, t.*
            FROM 
                (SELECT sal.id_sales, cust.id_customer, emp.id_employee, st.id_store, prod.id_product, trunc(date_sales), time_sales, amount
                FROM bl_3nf.sales sal
                JOIN bl_3nf.payments pay            
                ON sal.id_sales = pay.id_sales
                JOIN dwh.customers cust
                ON sal.id_customer = cust.customer_key
                JOIN dwh.employees emp
                ON sal.id_employee = emp.employee_key
                JOIN dwh.stores st
                ON sal.id_store = st.store_key
                JOIN dwh.products prod
                ON pay.id_product = prod.product_key
                MINUS
                SELECT sales_key, id_customer, id_employee, id_store, id_product, id_date, time_sale, amount
                FROM dwh.factsales) t
        LOG ERRORS INTO ERROR_FACT
        REJECT LIMIT UNLIMITED;

    END fact_dwh;

END nf_to_dwh;