--==============================================================
-- Table: ext_geo_data
--==============================================================
--select * from ext_geo_data;
drop table ext_geo_data;
    create table ext_geo_data
          (country_id           NUMBER(10,0),
           county_desc          VARCHAR2(200 CHAR),
           structure_code       NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR)
           )
    ORGANIZATION EXTERNAL (
        TYPE ORACLE_LOADER
        DEFAULT DIRECTORY external_geo_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL
                  (country_id integer external (4),
                   county_desc char(200),
                   structure_code integer external,
                   structure_desc char(200) )
             )
        location ('iso_3166_geo_un_countries.tab')
    )
    reject limit unlimited;

