CREATE OR REPLACE PACKAGE pkg_etl_insert_geo
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_regions;
    PROCEDURE merge_table_ce_regions;
    PROCEDURE insert_table_cities;
    PROCEDURE merge_table_ce_cities;
END pkg_etl_insert_geo;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_geo
AS
----------------------------------------------------
    PROCEDURE insert_table_regions
    IS
        BEGIN
            EXECUTE IMMEDIATE (' TRUNCATE TABLE cls_regions');
            INSERT INTO cls_regions (
                                        region_id,
                                        region_name
                                    )
            SELECT DISTINCT region,
               CASE 
                    WHEN region = 1
                        THEN ' Брестская область '
                    WHEN region = 2
                        THEN ' Витебская область '
                    WHEN region = 3
                        THEN ' Гомельская область '
                    WHEN region = 4
                        THEN ' Гродненская область '
                    WHEN region = 5
                        THEN ' Минская область '
                    WHEN region = 6
                        THEN ' Могилевская область '
                    WHEN region = 7
                        THEN ' город Минск '
                END AS region_name   
            FROM wrk_shops
            WHERE region  IS NOT NULL
            AND region < 8;
        COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;   

         END  insert_table_regions;
----------------------------------------------------
    PROCEDURE merge_table_ce_regions
    IS 
        BEGIN
        MERGE INTO ce_regions t USING
            ( SELECT region_id,
                     region_name 
              FROM cls_regions
              MINUS
              SELECT region_id,
                     region_name
              FROM ce_regions
              ) c
              ON ( c.region_id=t.region_id )
              WHEN matched THEN
              UPDATE SET t.region_name=c.region_name
              WHEN NOT matched THEN
              INSERT 
                    (region_surr_id,
                     region_id,
                     region_name,
                     insert_dt,
                     update_dt)
             VALUES 
                   (ce_regions_seq.nextval,
                    c.region_id,
                    c.region_name,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;
    END merge_table_ce_regions;
----------------------------------------------------
    PROCEDURE insert_table_cities
    IS
        BEGIN
            EXECUTE IMMEDIATE (' TRUNCATE TABLE cls_cities');
            INSERT INTO cls_cities (
                                        city_name,
                                        region_id
                                    )
            SELECT  INITCAP ( city ),
                    region 
            FROM wrk_shops
            WHERE city IS NOT NULL
            AND region IS NOT NULL
            AND region < 8
            UNION
            SELECT  INITCAP ( city ),
                    region
            FROM wrk_customers
            WHERE city IS NOT NULL
            AND region IS NOT NULL
            AND region < 8;
        COMMIT;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE; 
        END insert_table_cities;
----------------------------------------------------
PROCEDURE merge_table_ce_cities
    IS 
        BEGIN
        MERGE INTO ce_cities t USING
            ( SELECT city_name,
                     region_id 
              FROM cls_cities
              MINUS
              SELECT city_name,
                     region_surr_id as region_id
              FROM ce_cities
              ) c
              ON ( c.city_name=t.city_name )
              WHEN matched THEN
              UPDATE SET t.region_surr_id=c.region_id
              WHEN NOT matched THEN
              INSERT 
                    (city_surr_id,
                     city_name,
                     region_surr_id,
                     insert_dt,
                     update_dt)
             VALUES 
                   (ce_cities_seq.nextval,
                    c.city_name,
                    c.region_id,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;
    END merge_table_ce_cities;
----------------------------------------------------
END pkg_etl_insert_geo;