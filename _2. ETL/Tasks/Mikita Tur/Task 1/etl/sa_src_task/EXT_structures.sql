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
    