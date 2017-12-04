-- EXT_COUNTRIES.

    CREATE TABLE ext_countries
        (country_id     NUMBER ( 10 ),
         country_desc   VARCHAR2 ( 200 CHAR ),
         country_code   VARCHAR2 ( 3 )
         )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
         DEFAULT DIRECTORY ext_sources
         ACCESS PARAMETERS
            (records delimited BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated BY ';'
             missing field VALUES are NULL 
                (country_id INTEGER EXTERNAL (4),
                 country_desc CHAR(200),
                 country_code CHAR(3) )
             )
         LOCATION ('iso_3166.tab')
    )
    REJECT LIMIT UNLIMITED;