CREATE OR REPLACE PACKAGE pkg_etl_insert_shops
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_shops;
    PROCEDURE merge_table_ce_shops;

END pkg_etl_insert_shops;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_shops
AS
----------------------------------------------------
PROCEDURE insert_table_shops
IS
    BEGIN 
        EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_shops');
        INSERT INTO cls_shops
            (
                shop_id,
                shop_name,
                phone,
                address,
                city_id,
                manager_id
                )
        SELECT shop_code as shop_id,
               shop_name,
               wrk.phone,
               address||' ' || address_number as address,
               ce.city_surr_id as city_id,
               emp.employee_id as manager_id
        FROM wrk_shops wrk JOIN ce_cities ce ON wrk.city=ce.city_name
        JOIN ce_employees emp ON wrk.manager_code=emp.employee_id
        WHERE wrk.manager_code IS NOT NULL;
        COMMIT;
       
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;  
        
END insert_table_shops;

----------------------------------------------------
PROCEDURE merge_table_ce_shops
IS
    BEGIN 
         MERGE INTO ce_shops t USING
            ( SELECT shop_id,
                     shop_name,
                     phone,
                     address,
                     city_id,
                     manager_id
              FROM cls_shops
              MINUS
              SELECT shop_id,
                     shop_name,
                     phone,
                     address,
                     city_surr_id,
                     manager_id
              FROM ce_shops
              ) c
              ON ( c.shop_id=t.shop_id )
              WHEN matched THEN
              UPDATE SET t.shop_name=c.shop_name,
                         t.phone=c.phone,
                         t.address=c.address,
                         t.city_surr_id=c.city_id,
                         t.manager_id=c.manager_id
              WHEN NOT matched THEN
              INSERT 
                    (shop_surr_id,
                     shop_id,
                     shop_name,
                     phone,
                     address,
                     city_surr_id,
                     manager_id,
                     insert_dt,
                     update_dt)
             VALUES 
                   (ce_shops_seq.nextval,
                    c.shop_id,
                    c.shop_name,
                    c.phone,
                    c.address,
                    c.city_id,
                    c.manager_id,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;
END  merge_table_ce_shops;
----------------------------------------------------
END pkg_etl_insert_shops;