--EXEC system.pckg_drop.DROP_Proc('wrk_ext_cntr2structure_iso3166', 'Table');

create table wrk_ext_cntr2structure_iso3166
  (country_id           NUMBER(10,0),
  county_desc          VARCHAR2(200 CHAR),
  structure_code       NUMBER(10,0),
  structure_desc       VARCHAR2(200 CHAR)
  );