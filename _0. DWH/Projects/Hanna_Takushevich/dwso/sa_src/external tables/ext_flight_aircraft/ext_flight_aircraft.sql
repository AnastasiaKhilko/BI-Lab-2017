--==============================================================
-- Table: t_ext_flight_aircraft
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_flight_aircraft', Object_Type=>'TABLE');

CREATE TABLE ext_flight_aircraft
  (
    flight_code               VARCHAR2(20),
    aircraft_type                VARCHAR2(60)
  )
  ORGANIZATION EXTERNAL( TYPE oracle_loader 
    DEFAULT DIRECTORY ext_references ACCESS PARAMETERS ( 
      RECORDS DELIMITED BY NEWLINE 
        NOBADFILE 
        NODISCARDFILE 
        NOLOGFILE 
      FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL ( 
        flight_code               CHAR(20),
        aircraft_type                CHAR(60)
      ) 
    ) LOCATION ( 'flight_aircraft.csv' )
  )REJECT LIMIT UNLIMITED;