--==============================================================
-- Table: t_ext_geo_countries_iso3166
--==============================================================
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


