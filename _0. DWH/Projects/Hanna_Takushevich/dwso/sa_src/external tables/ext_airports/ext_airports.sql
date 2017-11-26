--==============================================================
-- Table: t_ext_airports
--==============================================================    
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_airports', Object_Type=>'TABLE');

CREATE TABLE ext_airports (
    airport_name varchar2(150),
    airport_city     VARCHAR2(50),
    airport_country varchar2(50),
    airport_iata varchar2(3),
    airport_icao varchar2(4),
    airport_faa varchar2(5)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                airport_name CHAR ( 150 ),
                airport_city     CHAR ( 50 ),
                airport_country CHAR ( 50 ),
                airport_iata CHAR ( 3 ),
                airport_icao CHAR ( 4 ),
                airport_faa CHAR ( 5 )
            )
        ) LOCATION ( 'airports.txt' )
    ) REJECT LIMIT UNLIMITED;     