-- WRK_FULL_DATA.
BEGIN
  pkg_drop.drop_proc(object_name => 'wrk_full_data', object_type => 'table');
END;

CREATE TABLE wrk_full_data
(
 country_id           NUMBER(10,0),
 county_desc          VARCHAR2(200 CHAR),
 structure_code       NUMBER(10,0),
 structure_desc       VARCHAR2(200 CHAR)
);