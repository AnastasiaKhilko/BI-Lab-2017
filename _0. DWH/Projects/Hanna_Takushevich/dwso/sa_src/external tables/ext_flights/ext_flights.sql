--==============================================================
-- Table: t_ext_flights
--==============================================================    
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_flights', Object_Type=>'TABLE');

CREATE TABLE ext_flights (
    route_code     VARCHAR2(10),
    airline_name varchar2(60),
    flight_duration VARCHAR2(10),
    flight_code varchar2(12),
    flight_date varchar2(15)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL (
                route_code     CHAR(10),
                airline_name CHAR(60),
                flight_duration CHAR(10),
                flight_code CHAR(12),
                flight_date CHAR(15)
            )
        ) LOCATION ( 'flights.csv' )
    ) REJECT LIMIT UNLIMITED;   