EXECUTE pckg_drop.drop_proc(object_name=>'wrk_geodata',object_type=>'table');
CREATE TABLE wrk_geodata
  (
    geo_id        NUMBER(8),
    city_name     VARCHAR2 ( 200 CHAR ),
    region_name   VARCHAR2 ( 200 CHAR ),
    district_name VARCHAR2 ( 200 CHAR ),
    population    NUMBER ( 10 ),
    years         VARCHAR2( 10 CHAR )
  );