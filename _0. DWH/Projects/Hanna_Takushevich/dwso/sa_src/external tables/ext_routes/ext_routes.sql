--==============================================================
-- Table: t_ext_routes
--==============================================================    
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_routes', Object_Type=>'TABLE');

CREATE TABLE ext_routes (
    route_code     VARCHAR2(10),
    airport_name_from varchar2(150),
    country_from VARCHAR2(200),
    airport_name_to varchar2(150),
    country_to varchar2(200)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL (
                route_code     CHAR(10),
                airport_name_from CHAR(150),
                country_from CHAR(200),
                airport_name_to CHAR(150),
                country_to CHAR(200)
            )
        ) LOCATION ( 'routes.csv' )
    ) REJECT LIMIT UNLIMITED;   