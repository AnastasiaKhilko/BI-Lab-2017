--EXEC system.pckg_drop.DROP_Proc('cl_regions', 'Table');  

CREATE TABLE cl_Regions (
  Region_id NUMBER(3),
  Region_name VARCHAR2(70),
  Continent_id NUMBER(3)
  );