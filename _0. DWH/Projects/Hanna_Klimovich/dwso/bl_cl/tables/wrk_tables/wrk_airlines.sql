--==============================================================
-- Table: wrk_airlines
--==============================================================

drop table wrk_airlines;

    create table wrk_airlines
          ( Airline_ID	NUMBER ( 10 ),
         Name	VARCHAR2 ( 200 CHAR ),
         Alias	VARCHAR2 ( 200 CHAR ),
         IATA VARCHAR2 ( 200 CHAR ),
         ICAO VARCHAR2 ( 10 CHAR ),
         Callsign VARCHAR2 ( 200 CHAR ),
         Country	VARCHAR2 ( 200 CHAR ),
         Active VARCHAR2 ( 10 CHAR )
           );
           
    truncate table wrk_airlines;
    
    insert into wrk_airlines 
    select * from sa_src.ext_airlines;
