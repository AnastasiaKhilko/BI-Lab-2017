CREATE OR REPLACE PACKAGE pkg_etl_insert_shops
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_shops;
    PROCEDURE merge_table_dim_shops;    
END pkg_etl_insert_shops;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_shops
AS
----------------------------------------------------
    PROCEDURE insert_table_shops
    IS 
        BEGIN
            EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_dim_shops');
            INSERT INTO cls_dim_shops
                       SELECT   shop_surr_id ,
                                shop_name,
                                ce.phone,
                                ce.address,
                                city.city_surr_id as city_id,
                                city.city_name,
                                reg.region_surr_id as region_id,
                                reg.region_name,
                                emp.employee_id,
                                emp.last_name,
                                emp.first_name,
                                emp.middle_name,
                                emp.gender
                        FROM ce_shops ce JOIN ce_cities city ON ce.city_surr_id=city.city_surr_id
                        JOIN ce_regions reg ON city.region_surr_id=reg.region_surr_id
                        JOIN ce_employees emp ON ce.manager_id=emp.employee_id;

            COMMIT;
            EXCEPTION
                WHEN OTHERS 
            THEN RAISE;  
    END insert_table_shops;
----------------------------------------------------
PROCEDURE merge_table_dim_shops
    IS 
        BEGIN
        MERGE INTO dim_shops t USING
            ( SELECT shop_id,
                     shop_name,
                     phone,
                     address,
                     city_id,
                     city_name,
                     region_id,
                     region_name,
                     manager_id,
                     manager_last_name,
                     manager_first_name,
                     manager_middle_name,
                     manager_gender
              FROM cls_dim_shops
              MINUS
              SELECT shop_id,
                     shop_name,
                     phone,
                     address,
                     city_id,
                     city_name,
                     region_id,
                     region_name,
                     manager_id,
                     manager_last_name,
                     manager_first_name,
                     manager_middle_name,
                     manager_gender
              FROM dim_shops  
              ) c
              ON ( c.shop_id=t.shop_id )
              WHEN matched THEN
              UPDATE SET 
                         t.shop_name=c.shop_name,
                         t.phone=c.phone,
                         t.address=c.address,
                         t.city_id=c.city_id,
                         t.city_name=c.city_name,
                         t.region_id=c.region_id,
                         t.region_name=c.region_name,
                         t.manager_id=c.manager_id,
                         t.manager_last_name=c.manager_last_name,
                         t.manager_first_name=c.manager_first_name,
                         t.manager_middle_name=c.manager_middle_name,
                         t.manager_gender=c.manager_gender             
              WHEN NOT matched THEN
              INSERT 
                    (shop_id, 
                     shop_surr_id,
                     shop_name,
                     phone,
                     address,
                     city_id,
                     city_name,
                     region_id,
                     region_name,
                     manager_id,
                     manager_last_name,
                     manager_first_name,
                     manager_middle_name,
                     manager_gender,
                     insert_dt,
                     update_dt)
             VALUES 
                   (dim_shops_seq.nextval,
                    c.shop_id,
                    c.shop_name,
                    c.phone,
                    c.address,
                    c.city_id,
                    c.city_name,
                    c.region_id,
                    c.region_name,
                    c.manager_id,
                    c.manager_last_name,
                    c.manager_first_name,
                    c.manager_middle_name,
                    c.manager_gender,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        

    END merge_table_dim_shops;
----------------------------------------------------
END pkg_etl_insert_shops;