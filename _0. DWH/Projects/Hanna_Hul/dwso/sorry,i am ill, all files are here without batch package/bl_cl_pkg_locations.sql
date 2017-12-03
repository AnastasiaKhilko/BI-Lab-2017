CREATE OR REPLACE PACKAGE  pkg_etl_load_locations
AUTHID CURRENT_USER
AS
    PROCEDURE load_wrk_countries;
    PROCEDURE load_locations_to_cls;
   -- PROCEDURE load_cls_regions;
    --PROCEDURE load_cls_continents;
end pkg_etl_load_locations;
/
create or replace PACKAGE BODY pkg_etl_load_locations
AS
PROCEDURE load_wrk_countries
IS
BEGIN
  
  load_to_wrk( ext_table => 'sa_src.ext_countries', wrk_table => 'wrk_countries');
  load_to_wrk( ext_table => 'sa_src.ext_geo_structure', wrk_table => 'wrk_structure');
  load_to_wrk( ext_table => 'sa_src.ext_cntr2structure', wrk_table => 'wrk_conuntry2struct');
END load_wrk_countries;

PROCEDURE load_locations_to_cls
is
begin
    EXECUTE IMMEDIATE 'truncate table cls_continents';
      INSERT
  INTO
    cls_continents
  SELECT
    child_code,
    structure_desc
  FROM
    wrk_structure
  WHERE
    parent_code = 1;
    EXECUTE IMMEDIATE 'truncate table cls_regions';
  INSERT
  INTO
    cls_regions
  SELECT
    child_code,
    structure_desc,
    parent_code
  FROM
    wrk_structure
  WHERE
    structure_level = 'Regions';
EXECUTE IMMEDIATE 'truncate table cls_countries';
INSERT INTO cls_countries
  SELECT DISTINCT
      cou.country_id,
      county_desc,
      country_code,
      structure_code
  FROM
      wrk_countries cou
      RIGHT JOIN wrk_conuntry2struct con
      ON cou.country_id = con.country_id;
  COMMIT;
end load_locations_to_cls;

end pkg_etl_load_locations;
/
exec pkg_etl_load_locations.load_wrk_countries;
exec pkg_etl_load_locations.load_locations_to_cls;
select*from cls_countries;
select*from sa_src.ext_countries;