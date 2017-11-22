-- ext_geo_countries_iso3166.
    create table EXT_COUNTRIES
        (COUNTRY_ID     number ( 10 ),
         COUNTRY_DESC   varchar2 ( 200 char ),
         COUNTRY_CODE   varchar2 ( 3 )
         )
    organization external
        (type ORACLE_LOADER
         default directory EXTERNAL_GEO_TABLES
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
