-- WRK_GEO_DATA.
DROP TABLE wrk_geo_data;
CREATE TABLE wrk_geo_data
(
 country_id           NUMBER(10,0),
 county_name          VARCHAR2(200 CHAR),
 structure_id         NUMBER(10,0),
 structure_name       VARCHAR2(200 CHAR)
);