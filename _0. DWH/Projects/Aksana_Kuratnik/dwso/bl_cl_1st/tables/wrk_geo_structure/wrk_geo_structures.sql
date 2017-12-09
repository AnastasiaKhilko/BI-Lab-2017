-- WRK_GEO_STRUCTURES.
DROP TABLE wrk_geo_structures;
CREATE TABLE wrk_geo_structures  
(
 child_code           NUMBER(10,0),
 parent_code          NUMBER(10,0),
 structure_name       VARCHAR2(200 CHAR),
 structure_level      VARCHAR2(200 CHAR)
);