-- EXT_FULL_DATA.
    CREATE TABLE ext_geo_data
          (country_id           NUMBER(10,0),
           county_desc          VARCHAR2(200 CHAR),
           structure_code       NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR)
           )
    ORGANIZATION EXTERNAL (
        TYPE oracle_loader
        DEFAULT DIRECTORY ext_sources
         ACCESS PARAMETERS
            (records delimited BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated BY ';'
             missing field VALUES are NULL
                  (
                   country_id INTEGER EXTERNAL (4),
                   county_desc CHAR(200),
                   structure_code INTEGER EXTERNAL,
                   structure_desc CHAR(200) )
             )
        LOCATION ('iso_3166_geo_un_contries.tab')
    )
    REJECT LIMIT UNLIMITED;
    