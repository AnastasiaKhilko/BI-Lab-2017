-- Creating tables.
-- ext_geo_countries_iso3166.
    create table EXT_COUNTRIES
        (COUNTRY_ID     number ( 10 ),
         COUNTRY_DESC   varchar2 ( 200 char ),
         COUNTRY_CODE   varchar2 ( 3 )
         )
    organization external
        (type ORACLE_LOADER
         default directory EXTERNAL_TABLES
         access parameters
            (RECORDS DELIMITED by 0x'0D0A'
             NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED by ';'
             MISSING FIELD values ARE null 
                (COUNTRY_ID integer external (4),
                 COUNTRY_DESC char(200),
                 COUNTRY_CODE char(3) )
             )
         location ('iso_3166.tab')
    )
    reject limit unlimited;
    
-- ext_geo_structure_iso3166.
    create table EXT_STRUCTURES  
          (CHILD_CODE           number(10,0),
           PARENT_CODE          number(10,0),
           STRUCTURE_DESC       varchar2(200 char),
           STRUCTURE_LEVEL      varchar2(200 char)
           )
    organization external (
        type ORACLE_LOADER
        default directory EXTERNAL_TABLES
         access parameters
            (RECORDS DELIMITED by 0x'0D'
             NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED by ';'
             MISSING FIELD values ARE null
                  (CHILD_CODE integer external (4),
                   PARENT_CODE integer external,
                   STRUCTURE_DESC char(200),
                   STRUCTURE_LEVEL char(200) )
             )
        location ('iso_3166_geo_un.tab')
    )
    reject limit unlimited;
    
-- ext_cntr2structure_iso3166.
    create table EXT_FULL_DATA
          (COUNTRY_ID           number(10,0),
           COUNTY_DESC          varchar2(200 char),
           STRUCTURE_CODE       number(10,0),
           STRUCTURE_DESC       varchar2(200 char)
           )
    organization external (
        type ORACLE_LOADER
        default directory EXTERNAL_TABLES
         access parameters
            (RECORDS DELIMITED by 0x'0D0A'
             NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED by ';'
             MISSING FIELD values ARE null
                  (COUNTRY_ID integer external (4),
                   COUNTY_DESC char(200),
                   STRUCTURE_CODE integer external,
                   STRUCTURE_DESC char(200) )
             )
        location ('iso_3166_geo_un_contries.tab')
    )
    reject limit unlimited;