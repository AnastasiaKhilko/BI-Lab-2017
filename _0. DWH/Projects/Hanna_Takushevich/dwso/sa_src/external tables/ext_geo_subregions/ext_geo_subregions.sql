--==============================================================
-- Table: t_ext_geodatasource_subregions
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_geo_subregions', Object_Type=>'TABLE');

CREATE TABLE ext_geo_subregions (
    subregion_id            VARCHAR2(4),
    subregion_name          VARCHAR2(200),
    subregion_country_key   VARCHAR2(3)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                subregion_id CHAR ( 4 ),
                subregion_name CHAR ( 200 ),
                subregion_country_key CHAR ( 3 )
            )
        ) LOCATION ( 'GEODATASOURCE-SUBREGION.TXT' )
    ) REJECT LIMIT UNLIMITED;