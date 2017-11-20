--EXEC system.pckg_drop.DROP_Proc('cl_Countries', 'Table');
  
CREATE TABLE cl_Countries (
  Country_id NUMBER(3),
  Country_code VARCHAR2(5),
  Country_name VARCHAR2(70),
  Region_id NUMBER(3)
  );