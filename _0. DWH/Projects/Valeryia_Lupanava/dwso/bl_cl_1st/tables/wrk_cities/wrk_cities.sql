-- WRK_CITIES.
BEGIN
  pkg_drop.drop_proc(object_name => 'wrk_cities', object_type => 'table');
END;

CREATE TABLE wrk_cities
(
 city_id     NUMBER ( 10 ),
 city_desc   VARCHAR2 ( 200 BYTE ),
 country_id  NUMBER ( 10 )
);