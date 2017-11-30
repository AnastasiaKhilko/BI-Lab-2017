CREATE OR REPLACE PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_customers;
    PROCEDURE merge_table_ce_customers;    
END pkg_etl_insert_customers;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_customers
AS
----------------------------------------------------
    PROCEDURE insert_table_customers
    IS 
        BEGIN
            EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_customers');
            INSERT INTO cls_customers
                       ( customer_id,
                         last_name,
                         first_name,
                         middle_name,
                         phone,
                         email,
                         age,
                         discount,
                         gender,
                         city_id) 
                 SELECT DISTINCT CASE 
                            WHEN region = 1
                                THEN 'AB' || passport 
                            WHEN region = 2
                                THEN 'BM' || passport
                            WHEN region = 3
                                THEN 'HB' || passport
                            WHEN region = 4
                                THEN 'KH' || passport
                            WHEN region = 5
                                THEN 'HC' || passport
                            WHEN region = 6
                                THEN 'KB' || passport
                            WHEN region = 7
                                THEN 'MP' || passport
                            END AS customer_code,
                           last_name,
                           first_name,
                           middle_name,
                           phone,
                           email,
                           age,
                           discount,
                           CASE 
                            WHEN substr (middle_name,-1) = 'à' 
                                THEN 'Æ'
                            ELSE 'Ì'
                           END AS gender,
                          ce.city_surr_id
                    FROM wrk_customers wrk join ce_cities ce on wrk.city=ce.city_name
                    WHERE first_name IS NOT NULL
                    AND last_name IS NOT NULL
                    AND middle_name IS NOT NULL
                    AND email IS NOT NULL
                    ;

            COMMIT;
            EXCEPTION
                WHEN OTHERS 
            THEN RAISE;  
    END insert_table_customers;
----------------------------------------------------
PROCEDURE merge_table_ce_customers
    IS 
        BEGIN
        MERGE INTO ce_customers t USING
            ( SELECT customer_id,
                    last_name,
                    first_name,
                    middle_name,
                    phone,
                    email,
                    age,
                    discount,
                    gender,
                    city_id 
              FROM cls_customers
              WHERE customer_id NOT IN (SELECT customer_id
                                        FROM CLS_CUSTOMERS
                                        GROUP BY customer_id
                                        HAVING COUNT (customer_id) > 1) 
              MINUS
              SELECT customer_id ,
                   last_name,
                   first_name,
                   middle_name,
                   phone,
                   email,
                   age,
                   discount,
                   gender,
                   city_surr_id 
            FROM ce_customers bl 
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
                         t.city_surr_id=c.city_id
              WHEN NOT matched THEN
              INSERT 
                    (  customer_surr_id, 
                       customer_id,
                       last_name,
                       first_name,
                       middle_name,
                       phone,
                       email,
                       age,
                       discount,
                       gender,
                       city_surr_id,
                       insert_dt,
                       update_dt)
             VALUES 
                   (ce_customers_seq.nextval,
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
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        

    END merge_table_ce_customers;
----------------------------------------------------
END pkg_etl_insert_customers;