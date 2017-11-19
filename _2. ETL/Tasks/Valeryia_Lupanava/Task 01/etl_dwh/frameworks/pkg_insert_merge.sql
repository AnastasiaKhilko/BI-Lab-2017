CREATE OR REPLACE PACKAGE pkg_etl_insert_cntn 
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_continents;
  PROCEDURE insert_table_regions;
  PROCEDURE insert_table_countries;
END pkg_etl_insert_cntn;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_cntn
AS
  ---------------------------------------------------
  PROCEDURE insert_table_continents
  IS
  BEGIN
    MERGE INTO ce_continents t USING
    ( SELECT * FROM bl_cl_lab.cls_continents
    MINUS
      SELECT * FROM ce_continents
    ) c ON ( c.continent_id = t.continent_id )
    WHEN matched THEN
    UPDATE SET t.continent_desc = c.continent_desc 
    WHEN NOT matched THEN
    INSERT
      (
        continent_ID ,
        continent_desc
      )
      VALUES
      (
        c.continent_ID ,
        c.continent_desc
      ) ;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END insert_table_continents;
  ---------------------------------------------------
  PROCEDURE insert_table_regions
  IS
  BEGIN
    MERGE INTO ce_regions t USING
    ( SELECT * FROM bl_cl_lab.cls_regions
    MINUS
      SELECT * FROM ce_regions
    ) c ON ( c.region_id = t.region_id )
    WHEN matched THEN
    UPDATE SET t.region_desc = c.region_desc 
    WHEN NOT matched THEN
    INSERT
      (
        region_ID ,
        region_desc,
        continent_id
      )
      VALUES
      (
        c.region_ID ,
        c.region_desc,
        c.continent_id
      ) ;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END insert_table_regions;
---------------------------------------------------
  PROCEDURE insert_table_countries
  IS
  BEGIN
    MERGE INTO ce_countries t USING
    ( SELECT * FROM bl_cl_lab.cls_countries
    MINUS
      SELECT * FROM ce_countries
    ) c ON ( c.country_id = t.country_id )
    WHEN matched THEN
    UPDATE SET t.country_desc = c.country_desc 
    WHEN NOT matched THEN
    INSERT
      (
        country_ID ,
        country_desc,
        country_code,
        region_id
      )
      VALUES
      (
        c.country_ID ,
        c.country_desc,
        c.country_code,
        c.region_id
      ) ;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END insert_table_countries;
  
END pkg_etl_insert_cntn;
