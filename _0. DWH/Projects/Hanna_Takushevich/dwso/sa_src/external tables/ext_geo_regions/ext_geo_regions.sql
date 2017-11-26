--==============================================================
-- Table: t_ext_geodatasource_regions
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_geo_regions', Object_Type=>'TABLE');

CREATE TABLE ext_geo_regions (
    region_id     NUMBER(10),
    region_name   VARCHAR2(200 CHAR)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                region_id INTEGER EXTERNAL ( 10 ),
                region_name CHAR ( 200 )
            )
        ) LOCATION ( 'GEODATASOURCE-REGION.TXT' )
    ) REJECT LIMIT UNLIMITED;