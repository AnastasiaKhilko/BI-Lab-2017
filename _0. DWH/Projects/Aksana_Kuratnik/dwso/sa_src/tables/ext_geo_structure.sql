-- EXT_STRUCTURES.
    CREATE TABLE ext_geo_structures  
          (child_code           NUMBER(10,0),
           parent_code          NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR),
           structure_level      VARCHAR2(200 CHAR)
           )
    ORGANIZATION EXTERNAL (
        TYPE oracle_loader
        DEFAULT DIRECTORY ext_sources
         ACCESS PARAMETERS
            (records delimited BY 0x'0D'
             nobadfile nodiscardfile nologfile fields terminated BY ';'
             missing field VALUES are NULL
                  (
                   child_code INTEGER EXTERNAL (4),
                   parent_code INTEGER EXTERNAL,
                   structure_desc CHAR(200),
                   structure_level CHAR(200) 
                   )
             )
        LOCATION ('iso_3166_geo_un.tab')
    )
    REJECT LIMIT UNLIMITED;