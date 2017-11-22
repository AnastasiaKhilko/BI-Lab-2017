--==============================================================
-- Table: t_ext_geo_countries_iso3166
--==============================================================
select * from ext_geo_countries_iso3166;
drop table ext_geo_countries_iso3166;
    CREATE TABLE ext_geo_countries_iso3166
        (country_id     NUMBER ( 10 ),
         country_desc   VARCHAR2 ( 200 CHAR ),
         country_code   VARCHAR2 ( 3 )
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (country_id integer external (4),
                 country_desc char(200),
                 country_code char(3) )
             )
         LOCATION ('iso_3166.tab')
    )
    reject LIMIT unlimited;

--==============================================================
-- Table: t_ext_geo_structure_iso3166                           
--==============================================================
select * from ext_geo_structure_iso3166;
drop table ext_geo_structure_iso3166;
    create table ext_geo_structure_iso3166  
          (child_code           NUMBER(10,0),
           parent_code          NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR),
           structure_level      VARCHAR2(200 CHAR)
           )
    ORGANIZATION EXTERNAL (
        TYPE ORACLE_LOADER
        DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL
                  (child_code integer external (4),
                   parent_code integer external,
                   structure_desc char(200),
                   structure_level char(200) )
             )
        location ('iso_3166_geo_un.tab')
    )
    reject limit unlimited;

--==============================================================
-- Table: t_ext_cntr2structure_iso3166
--==============================================================
select * from ext_cntr2structure_iso3166;
drop table ext_cntr2structure_iso3166;
    create table ext_cntr2structure_iso3166
          (country_id           NUMBER(10,0),
           county_desc          VARCHAR2(200 CHAR),
           structure_code       NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR)
           )
    ORGANIZATION EXTERNAL (
        TYPE ORACLE_LOADER
        DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL
                  (country_id integer external (4),
                   county_desc char(200),
                   structure_code integer external,
                   structure_desc char(200) )
             )
        location ('iso_3166_geo_un_contries.tab')
    )
    reject limit unlimited;

grant select on sa_src.EXT_CNTR2STRUCTURE_ISO3166 to bl_cl;
grant select on sa_src.EXT_GEO_COUNTRIES_ISO3166 to bl_cl;
grant select on sa_src.EXT_GEO_STRUCTURE_ISO3166 to bl_cl;

grant all privileges to bl_cl;

EXEC grants_mgmt.grant_blat ('SELECT', 'sa_SRC','ext_geo_countries_iso3166','BL_CL');
EXEC grants_mgmt.grant_blat ('SELECT', 'SRC','ext_geo_structure_iso3166','BL_CL');
EXEC grants_mgmt.grant_blat ('SELECT', 'SRC','ext_cntr2structure_iso3166','BL_CL');


CREATE OR REPLACE PACKAGE grants_mgmt
AUTHID CURRENT_USER
AS
  PROCEDURE GRANT_BLAT (GRANT_NAME IN VARCHAR2,
						SCHEMA_NAME IN VARCHAR2,
						OBJECT_NAME IN VARCHAR2,
						USER_NAME IN VARCHAR2);
						
  PROCEDURE GRANT_BLAT (GRANT_NAME IN VARCHAR2,
						USER_NAME IN VARCHAR2,
						WAO IN BOOLEAN := FALSE);
END grants_mgmt;
/

CREATE OR REPLACE PACKAGE BODY grants_mgmt AS
 PROCEDURE GRANT_BLAT (GRANT_NAME IN VARCHAR2,
						SCHEMA_NAME IN VARCHAR2,
						OBJECT_NAME IN VARCHAR2,
						USER_NAME IN VARCHAR2 ) 
  IS
  BEGIN
	  EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' ON ' || SCHEMA_NAME || '.' || OBJECT_NAME || ' TO ' || USER_NAME);
  END GRANT_BLAT;
  
PROCEDURE GRANT_BLAT (GRANT_NAME VARCHAR2, USER_NAME VARCHAR2, WAO IN BOOLEAN := FALSE)   IS
  BEGIN
      IF WAO THEN
        EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' TO ' || USER_NAME || ' WITH ADMIN OPTION');
      END IF;
      EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' TO ' || USER_NAME);
  END;
END grants_mgmt;
/

