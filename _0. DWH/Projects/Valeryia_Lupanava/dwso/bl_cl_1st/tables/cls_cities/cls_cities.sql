-- CLS_CITIES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_cities', object_type => 'table');
END;  

CREATE TABLE cls_cities
  (
    city_id    NUMBER ( 10 ) NOT NULL,
    city_desc  VARCHAR2(200 CHAR) NOT NULL,
    country_id NUMBER ( 10 ) NOT NULL
  );