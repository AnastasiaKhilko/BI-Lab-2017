--==============================================================
-- Table: t_ext_geodatasource_cities
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_geo_cities', Object_Type=>'TABLE');

CREATE TABLE ext_geo_cities (
    cc_fips     VARCHAR2(2),
    city_name   VARCHAR2(200 CHAR)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                cc_fips CHAR ( 2 ),
                city_name CHAR ( 200 )
            )
        ) LOCATION ( 'GEODATASOURCE-CITIES-FREE.TXT' )
    ) REJECT LIMIT UNLIMITED;