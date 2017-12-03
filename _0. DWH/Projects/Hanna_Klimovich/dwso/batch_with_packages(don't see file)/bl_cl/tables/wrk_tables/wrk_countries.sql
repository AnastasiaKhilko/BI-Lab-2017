--==============================================================
-- Table: wrk_geo_data
--==============================================================

execute pckg_drop.DROP_Proc('wrk_geo_data','TABLE');

create table wrk_geo_data
          (country_id           NUMBER(10,0),
           county_desc          VARCHAR2(200 CHAR),
           structure_code       NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR)
           );
           
truncate table wrk_geo_data;
   
/*insert into wrk_geo_data
select * from sa_src.ext_geo_data;*/
