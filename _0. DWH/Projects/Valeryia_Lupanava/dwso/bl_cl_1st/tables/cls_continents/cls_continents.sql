-- CLS_CONTINENTS.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_continents', object_type => 'table');
END;  

CREATE TABLE cls_continents
  (
    continent_id   NUMBER ( 10 ) NOT NULL,
    continent_desc VARCHAR2 ( 200 CHAR ) NOT NULL
  );
