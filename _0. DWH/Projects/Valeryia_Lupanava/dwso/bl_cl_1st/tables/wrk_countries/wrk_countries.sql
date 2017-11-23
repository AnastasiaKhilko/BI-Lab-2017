-- WRK_COUNTRIES.
BEGIN
  pkg_drop.drop_proc(object_name => 'wrk_countries', object_type => 'table');
END;

CREATE TABLE wrk_countries
(
 country_id     NUMBER ( 10 ),
 country_desc   VARCHAR2 ( 200 CHAR ),
 country_code   VARCHAR2 ( 3 )
);