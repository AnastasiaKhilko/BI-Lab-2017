--==============================================================
-- Table: t_ext_airlines
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_airlines', Object_Type=>'TABLE');

CREATE TABLE ext_airlines (
    airline_name varchar2(60),
    icao_iata_codes     VARCHAR2(8),
    airline_country   VARCHAR2(60 CHAR)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                 airline_name CHAR(60),
                icao_iata_codes     CHAR ( 8 ),
                airline_country   CHAR ( 60 )
            )
        ) LOCATION ( 'airlines.txt' )
    ) REJECT LIMIT UNLIMITED;   