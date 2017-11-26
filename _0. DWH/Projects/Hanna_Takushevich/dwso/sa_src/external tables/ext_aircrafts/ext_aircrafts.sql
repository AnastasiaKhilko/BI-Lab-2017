--==============================================================
-- Table: t_ext_aircrafts
--==============================================================   
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_aircrafts', Object_Type=>'TABLE');

CREATE TABLE ext_aircrafts (
    aircraft_type varchar2(50),
    aircraft_country     VARCHAR2(50),
    engines_num number,
    first_flight_year number(4),
    entry_year number(4),
    end_prod varchar2(20),
    amount varchar2(30),
    amount_in_service varchar2(20)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                aircraft_type CHAR(50),
                aircraft_country     CHAR(50),
                engines_num INTEGER EXTERNAL,
                first_flight_year INTEGER EXTERNAL(4),
                entry_year INTEGER EXTERNAL (4),
                end_prod CHAR(20),
                amount CHAR(30),
                amount_in_service CHAR(20)
            )
        ) LOCATION ( 'aircrafts.txt' )
    ) REJECT LIMIT UNLIMITED;     