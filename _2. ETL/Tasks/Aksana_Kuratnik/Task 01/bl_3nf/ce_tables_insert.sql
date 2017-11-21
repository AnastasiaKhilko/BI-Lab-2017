
MERGE INTO ce_continents co USING
    ( SELECT * FROM bl_cl_lab1.cls_continents
    MINUS
      SELECT * FROM ce_continents
    ) c ON ( c.continent_id = co.continent_id )
    WHEN matched THEN
    UPDATE SET co.continent_name = c.continent_name 
    WHEN NOT matched THEN
    INSERT
      (
        continent_ID ,
        continent_name
      )
      VALUES
      (
        c.continent_ID ,
        c.continent_name
      ) ;
    COMMIT;
    

    
MERGE INTO ce_regions r USING
    ( SELECT * FROM bl_cl_lab1.cls_regions
    MINUS
      SELECT * FROM ce_regions
    ) c ON ( c.region_id = r.region_id )
    WHEN matched THEN
    UPDATE SET r.region_name = c.region_name 
    WHEN NOT matched THEN
    INSERT
      (
        region_ID ,
        region_name,
        continent_id
      )
      VALUES
      (
        c.region_ID ,
        c.region_name,
        c.continent_id
      ) ;
    COMMIT;


MERGE INTO ce_countries co USING
    ( SELECT * FROM bl_cl_lab1.cls_countries
    MINUS
      SELECT * FROM ce_countries
    ) c ON ( c.country_id = co.country_id )
    WHEN matched THEN
    UPDATE SET co.country_name = c.country_name
    WHEN NOT matched THEN
    INSERT
      (
        country_ID ,
        country_name,
        country_code,
        region_id
      )
      VALUES
      (
        c.country_ID ,
        c.country_name,
        c.country_code,
        c.region_id
      ) ;
    COMMIT;

