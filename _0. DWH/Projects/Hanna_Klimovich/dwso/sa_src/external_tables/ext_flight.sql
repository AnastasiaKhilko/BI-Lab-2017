--==============================================================
-- Table: ext_flight
--==============================================================
--select * from ext_flight;
drop table ext_flight;
    create table ext_flight
          (
f_YEAR		 NUMBER,
QUARTER		  NUMBER,
f_MONTH	 	  NUMBER,
DAY_OF_MONTH	  NUMBER,
DAY_OF_WEEK	  NUMBER,
FL_DATE		 VARCHAR2(200 CHAR),
UNIQUE_CARRIER	 	VARCHAR2(200 CHAR),
AIRLINE_ID	NUMBER,
CARRIER		 	VARCHAR2(10 CHAR),
TAIL_NUM 	 	VARCHAR2(20 CHAR),	
FL_NUM		 NUMBER,
ORIGIN_AIRPORT_ID NUMBER,	
ORIGIN_AIRPORT_SEQ_ID	NUMBER,
ORIGIN_CITY_MARKET_ID	NUMBER,
ORIGIN	 			VARCHAR2(8 CHAR),
ORIGIN_CITY_NAME		VARCHAR2(200 CHAR),
ORIGIN_STATE_ABR	VARCHAR2(5 CHAR),
ORIGIN_STATE_NM	 	VARCHAR2(200 CHAR),
ORIGIN_WAC		NUMBER,
DEST_AIRPORT_ID		NUMBER,
DEST_AIRPORT_SEQ_ID	NUMBER,
DEST_CITY_MARKET_ID	NUMBER,
DEST			VARCHAR2(8 CHAR),
DEST_CITY_NAME		VARCHAR2(200 CHAR),
DEST_STATE_ABR		VARCHAR2(5 CHAR),
DEST_STATE_NM		NUMBER,
CRS_DEP_TIME		NUMBER,
DEP_TIME		NUMBER,
DEP_DELAY		NUMBER,
DEP_DELAY_NEW		NUMBER,
DEP_DEL15		NUMBER,
CRS_ARR_TIME		NUMBER,
ARR_TIME		NUMBER,
ARR_DELAY		NUMBER,
ARR_DELAY_NEW		NUMBER,
ARR_DEL15		NUMBER,
CRS_ELAPSED_TIME	NUMBER,
ACTUAL_ELAPSED_TIME	NUMBER,
AIR_TIME		NUMBER,
FLIGHTS			NUMBER,
DISTANCE		NUMBER,
DISTANCE_GROUP		NUMBER,
PLANE_ID NUMBER,
PILOT_ID NUMBER,
CARRIER_DELAY		NUMBER,
WEATHER_DELAY		NUMBER,
NAS_DELAY		NUMBER,
SECURITY_DELAY		NUMBER,
LATE_AIRCRAFT_DELAY	NUMBER
           ) 
    ORGANIZATION EXTERNAL (
        TYPE ORACLE_LOADER
        DEFAULT DIRECTORY external_flight_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL
                  (
F_YEAR		integer external,
QUARTER	         integer external,
F_MONTH	          integer external,
DAY_OF_MONTH	 integer external,
DAY_OF_WEEK	 integer external,
FL_DATE		 char(200),
UNIQUE_CARRIER	 char(200),
AIRLINE_ID	 integer external,
CARRIER		 char(10),
TAIL_NUM 	 char(20),	
FL_NUM		 integer external,
ORIGIN_AIRPORT_ID integer external,	
ORIGIN_AIRPORT_SEQ_ID	integer external,
ORIGIN_CITY_MARKET_ID	integer external,
ORIGIN	 		char(8),
ORIGIN_CITY_NAME	char(200),
ORIGIN_STATE_ABR	char(5),
ORIGIN_STATE_NM	 	char(200),
ORIGIN_WAC		integer external (2),
DEST_AIRPORT_ID		integer external (8),
DEST_AIRPORT_SEQ_ID	integer external (8),
DEST_CITY_MARKET_ID	integer external (8),
DEST			char(8),
DEST_CITY_NAME		char(200),
DEST_STATE_ABR		char(5),
DEST_STATE_NM		integer external,
CRS_DEP_TIME		integer external (4),
DEP_TIME		integer external (4),
DEP_DELAY		integer external (8),
DEP_DELAY_NEW		integer external (8),
DEP_DEL15		integer external (1),
CRS_ARR_TIME		integer external (4),
ARR_TIME		integer external (4),
ARR_DELAY		integer external (8),
ARR_DELAY_NEW		integer external (8),
ARR_DEL15		integer external (1),
CRS_ELAPSED_TIME	integer external (8),
ACTUAL_ELAPSED_TIME	integer external (8),
AIR_TIME		integer external (4),
FLIGHTS			integer external (4),
DISTANCE		integer external (8),
DISTANCE_GROUP		integer external (2),
PLANE_ID integer external,
PILOT_ID integer external,
CARRIER_DELAY		integer external (4),
WEATHER_DELAY		integer external (4),
NAS_DELAY		integer external (4),
SECURITY_DELAY		integer external (4),
LATE_AIRCRAFT_DELAY	integer external (4)

                  )
             )
        location ('flight.csv')
    )
    reject limit unlimited;


