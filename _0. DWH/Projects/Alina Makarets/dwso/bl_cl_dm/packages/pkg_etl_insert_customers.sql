CREATE OR REPLACE PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_customers;
    PROCEDURE merge_table_dim_customers;    
END pkg_etl_insert_customers;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_customers
AS
----------------------------------------------------
    PROCEDURE insert_table_customers
    IS 
        BEGIN
            EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_dim_customers');
            INSERT INTO cls_dim_customers
                       SELECT DISTINCT customer_surr_id as customer_id,
                           last_name,
                           first_name,
                           middle_name,
                           phone,
                           email,
                           age,
                           discount,
                           gender,
                           city.city_surr_id,
                           city.city_name,
                           reg.region_surr_id,
                           reg.region_name
                    FROM ce_customers cust LEFT JOIN ce_cities city ON cust.city_surr_id=city.city_surr_id
                    LEFT JOIN ce_regions reg ON city.region_surr_id=reg.region_surr_id;
            COMMIT;
            EXCEPTION
                WHEN OTHERS 
            THEN RAISE;  
    END insert_table_customers;
----------------------------------------------------
PROCEDURE merge_table_dim_customers
    IS 
        BEGIN
        MERGE INTO dim_customers t USING
            ( SELECT 
                    customer_id,
                    last_name,
                    first_name,
                    middle_name,
                    phone,
                    email,
                    age,
                    discount,
                    gender,
                    city_id,
                    city_name,
                    region_id,
                    region_name
              FROM cls_dim_customers
              MINUS
              SELECT 
                    customer_surr_id,
                    last_name,
                    first_name,
                    middle_name,
                    phone,
                    email,
                    age,
                    discount,
                    gender,
                    city_id,
                    city_name,
                    region_id,
                    region_name
            FROM dim_customers  
              ) c
              ON ( c.customer_id=t.customer_id )
              WHEN matched THEN
              UPDATE SET 
                         t.last_name=c.last_name,
                         t.first_name=c.first_name,
                         t.middle_name=c.middle_name,
                         t.phone=c.phone,
                         t.email=c.email,
                         t.age=c.age,
                         t.discount=c.discount,
                         t.gender=c.gender,
                         t.city_id=c.city_id,
                         t.city_name=c.city_name,
                         t.region_id=c.region_id,
                         t.region_name=c.region_name                         
              WHEN NOT matched THEN
              INSERT 
                    (  customer_id, 
                       customer_surr_id,
                       last_name,
                       first_name,
                       middle_name,
                       phone,
                       email,
                       age,
                       discount,
                       gender,
                       city_id,
                       city_name,
                       region_id,
                       region_name,
                       insert_dt,
                       update_dt)
             VALUES 
                   (dim_customers_seq.nextval,
                    c.customer_id,
                    c.last_name,
                    c.first_name,
                    c.middle_name,
                    c.phone,
                    c.email,
                    c.age,
                    c.discount,
                    c.gender,
                    c.city_id,
                    c.city_name,
                    c.region_id,
                    c.region_name,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        

    END merge_table_dim_customers;
----------------------------------------------------
END pkg_etl_insert_customers;