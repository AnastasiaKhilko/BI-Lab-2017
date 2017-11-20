--EXEC system.pckg_drop.DROP_Proc('wrk_ext_geo_structure_iso3166', 'Table'); 
       
create table wrk_ext_geo_structure_iso3166  
  (child_code           NUMBER(10,0),
  parent_code          NUMBER(10,0),
  structure_desc       VARCHAR2(200 CHAR),
  structure_level      VARCHAR2(200 CHAR)
  );
       