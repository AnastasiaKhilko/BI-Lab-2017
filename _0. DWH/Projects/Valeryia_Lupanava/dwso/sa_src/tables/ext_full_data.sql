-- ext_cntr2structure_iso3166.
    create table EXT_FULL_DATA
          (COUNTRY_ID           number(10,0),
           COUNTY_DESC          varchar2(200 char),
           STRUCTURE_CODE       number(10,0),
           STRUCTURE_DESC       varchar2(200 char)
           )
    organization external (
        type ORACLE_LOADER
        default directory EXTERNAL_GEO_TABLES
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