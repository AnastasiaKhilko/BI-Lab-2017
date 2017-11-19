    
  exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('wrk_geo_countries_iso3166', 'TABLE');
  CREATE TABLE wrk_geo_countries_iso3166
        (country_id     NUMBER ( 10 ),
         country_desc   VARCHAR2 ( 200 CHAR ),
         country_code   VARCHAR2 ( 3 )
         );
         
  exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('wrk_geo_structure_iso3166', 'TABLE');
  create table wrk_geo_structure_iso3166  
          (child_code           NUMBER(10,0),
           parent_code          NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR),
           structure_level      VARCHAR2(200 CHAR)
           );
           
  exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('wrk_cntr2structure_iso3166', 'TABLE'); 
   create table wrk_cntr2structure_iso3166
          (country_id           NUMBER(10,0),
           county_desc          VARCHAR2(200 CHAR),
           structure_code       NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR)
           );
  
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('cl_Continents', 'TABLE'); 
CREATE TABLE cl_Continents (
  Continent_id NUMBER(3) PRIMARY KEY,
  Continent_name VARCHAR2(70) NOT NULL
  );

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('cl_Regions', 'TABLE'); 
CREATE TABLE cl_Regions (
  Region_id NUMBER(3) PRIMARY KEY,
  Region_name VARCHAR2(70) NOT NULL,
  Continent_id NUMBER(3) NOT NULL
  );

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('cl_Countries', 'TABLE');   
CREATE TABLE cl_Countries (
  Country_id NUMBER(3) PRIMARY KEY,
  Country_code VARCHAR2(5),-- NOT NULL,
  Country_name VARCHAR2(70) NOT NULL,
  Region_id NUMBER(3) NOT NULL
  );
  
 /*ERROR_*/ 
exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_Continents','TABLE');
exec dbms_errlog.create_error_log('CL_Continents','ERROR_Continents') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_Regions','TABLE');
exec dbms_errlog.create_error_log('CL_Regions','ERROR_Regions') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_Countries','TABLE');
exec dbms_errlog.create_error_log('CL_Countries','ERROR_Countries') ;
