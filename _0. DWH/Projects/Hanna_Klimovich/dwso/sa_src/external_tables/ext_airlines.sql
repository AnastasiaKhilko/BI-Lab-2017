--==============================================================
-- Table: ext_airlines
--==============================================================
--select * from ext_airlines;
drop table ext_airlines;
    create table ext_airlines
          ( Airline_ID	NUMBER ( 10 ),
         Name	VARCHAR2 ( 200 CHAR ),
         Alias	VARCHAR2 ( 200 CHAR ),
         IATA VARCHAR2 ( 200 CHAR ),
         ICAO VARCHAR2 ( 10 CHAR ),
         Callsign VARCHAR2 ( 200 CHAR ),
         Country	VARCHAR2 ( 200 CHAR ),
         Active VARCHAR2 ( 10 CHAR )
           )
    ORGANIZATION EXTERNAL (
        TYPE ORACLE_LOADER
        DEFAULT DIRECTORY external_airline_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL
                  (Airline_ID	integer external (8),
                Name	char(200),
                Alias	char(200),
                IATA  char(200),
                ICAO  char(10),
                Callsign char(200),
                Country	char(200),
                Active char(10) )
             )
        location ('airlines.csv')
    )
    reject limit unlimited;
    
    
