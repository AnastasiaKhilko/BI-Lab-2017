CREATE OR REPLACE PACKAGE WRK_TO_CL_PKG AS 
PROCEDURE WRK_CL_airlines;
PROCEDURE WRK_CL_COUNTRY;
PROCEDURE WRK_CL_FLIGHT;
PROCEDURE WRK_CL_PILOT;
PROCEDURE WRK_CL_PLANE;
PROCEDURE WRK_CL_REGION;
PROCEDURE WRK_CL_STATE;
   END;
  / 
  
CREATE OR REPLACE PACKAGE body  WRK_TO_CL_PKG AS  
PROCEDURE WRK_CL_AIRLINES AS
   BEGIN
    EXECUTE IMMEDIATE ' TRUNCATE TABLE BL_CL.cl_airlines';
    INSERT INTO BL_CL.cl_airlines
SELECT DISTINCT air.Airline_ID AS airline_id,
  air.name          AS a_name,
  air.ICAO            AS ICAO,
  air.Active          AS ACTIVE

FROM
  (SELECT DISTINCT Airline_ID , name , ICAO , Active FROM wrk_airlines
  ) air
WHERE Airline_ID IS NOT NULL
AND name       IS NOT NULL
AND ICAO         IS NOT NULL 
AND ICAO != '0' 
AND Active       IS NOT NULL ;
    
   END;
   
PROCEDURE WRK_CL_COUNTRY AS
   BEGIN
EXECUTE IMMEDIATE ' TRUNCATE TABLE cl_country;';

INSERT INTO cl_country
SELECT country.country_id AS country_num,
  country.county_desc     AS country_name,
  country.structure_code  AS region_num
FROM
  (SELECT DISTINCT country_id, county_desc,structure_code FROM wrk_geo_data
  ) country
WHERE country_id   IS NOT NULL
AND county_desc    IS NOT NULL
AND structure_code IS NOT NULL;
  
   END;
   
PROCEDURE WRK_CL_FLIGHT AS
   BEGIN
    EXECUTE IMMEDIATE ' TRUNCATE TABLE cl_flight;';
 
INSERT INTO cl_flight
SELECT fl.f_YEAR ,
  f_MONTH ,
  DAY_OF_MONTH ,
  DAY_OF_WEEK ,
  to_char( TO_DATE(FL_DATE,'DD-MM-YY')) ,
  UNIQUE_CARRIER ,
  AIRLINE_ID ,
  CARRIER ,
  TAIL_NUM ,
  FL_NUM ,
  ORIGIN_AIRPORT_ID ,
  ORIGIN_AIRPORT_SEQ_ID ,
  ORIGIN_CITY_MARKET_ID ,
  ORIGIN ,
  ORIGIN_CITY_NAME ,
  ORIGIN_STATE_ABR ,
  ORIGIN_STATE_NM ,
  ORIGIN_WAC ,
  DEST_AIRPORT_ID ,
  DEST_AIRPORT_SEQ_ID ,
  DEST_CITY_MARKET_ID ,
  DEST ,
  DEST_CITY_NAME ,
  DEST_STATE_ABR ,
  DEST_STATE_NM ,
  CRS_DEP_TIME ,
  DEP_TIME ,
  DEP_DELAY ,
  DEP_DELAY_NEW ,
  DEP_DEL15 ,
  CRS_ARR_TIME ,
  ARR_TIME ,
  ARR_DELAY ,
  ARR_DELAY_NEW ,
  ARR_DEL15 ,
  CRS_ELAPSED_TIME ,
  ACTUAL_ELAPSED_TIME ,
  AIR_TIME ,
  FLIGHTS ,
  DISTANCE ,
  DISTANCE_GROUP ,
  PLANE_ID ,
  PILOT_ID
FROM
  (SELECT DISTINCT f_YEAR ,
    f_MONTH ,
    DAY_OF_MONTH ,
    DAY_OF_WEEK ,
    FL_DATE ,
    UNIQUE_CARRIER ,
    AIRLINE_ID ,
    CARRIER ,
    TAIL_NUM ,
    FL_NUM ,
    ORIGIN_AIRPORT_ID ,
    ORIGIN_AIRPORT_SEQ_ID ,
    ORIGIN_CITY_MARKET_ID ,
    ORIGIN ,
    ORIGIN_CITY_NAME ,
    ORIGIN_STATE_ABR ,
    ORIGIN_STATE_NM ,
    ORIGIN_WAC ,
    DEST_AIRPORT_ID ,
    DEST_AIRPORT_SEQ_ID ,
    DEST_CITY_MARKET_ID ,
    DEST ,
    DEST_CITY_NAME ,
    DEST_STATE_ABR ,
    DEST_STATE_NM ,
    CRS_DEP_TIME ,
    DEP_TIME ,
    DEP_DELAY ,
    DEP_DELAY_NEW ,
    DEP_DEL15 ,
    CRS_ARR_TIME ,
    ARR_TIME ,
    ARR_DELAY ,
    ARR_DELAY_NEW ,
    ARR_DEL15 ,
    CRS_ELAPSED_TIME ,
    ACTUAL_ELAPSED_TIME ,
    AIR_TIME ,
    FLIGHTS ,
    DISTANCE ,
    DISTANCE_GROUP ,
    PLANE_ID ,
    PILOT_ID
  FROM wrk_flight
  ) fl
WHERE F_YEAR      IS NOT NULL
AND f_MONTH       IS NOT NULL
AND DAY_OF_MONTH  IS NOT NULL
AND TAIL_NUM      IS NOT NULL
AND CARRIER       IS NOT NULL
AND DEST_STATE_NM IS NOT NULL
AND DEP_TIME      IS NOT NULL
AND PLANE_ID      IS NOT NULL
AND PILOT_ID      IS NOT NULL ;   
    
   END;
   
PROCEDURE WRK_CL_PILOT AS
   BEGIN
EXECUTE IMMEDIATE ' TRUNCATE TABLE cl_pilot; ';
INSERT INTO cl_pilot
SELECT pl.pilot_id AS pilot_id,
  pl.national_id   AS national_id,
  pl.name          AS p_name,
  pl.surname       AS surname,
  pl.gender        AS gender,
  pl.age           AS age,
  pl.hours_in_air  AS hours_in_air,
  pl.begin_date    AS begin_date,
  pl.end_date      AS end_date 
FROM
  (SELECT DISTINCT pilot_id,
    national_id,
    name,
    surname,
    gender,
    age,
    hours_in_air,
    begin_date,
    end_date
  FROM wrk_pilot
  ) pl
WHERE pilot_id   IS NOT NULL
AND national_id  IS NOT NULL
AND name         IS NOT NULL
AND surname      IS NOT NULL
AND gender       IS NOT NULL
AND age          IS NOT NULL
AND hours_in_air IS NOT NULL
and begin_date IS NOT NULL
AND end_date IS NOT NULL;

    
   END;
    
PROCEDURE WRK_CL_PLANE AS
   BEGIN
EXECUTE IMMEDIATE ' TRUNCATE TABLE cl_PLANE;'; 
INSERT INTO cl_plane
SELECT pln.ssd_name AS MODEL_NAME,
  pln.manufacturer    AS MANUFACTURER,
  pln.long_name       AS LONG_NAME ,
  pln.short_name      AS SHORT_NAME,
  pln.begin_date      AS BEGIN_DATE,
  pln.end_date        AS END_DATE
FROM
  (SELECT DISTINCT ssd_name ,
    manufacturer ,
    long_name ,
    short_name,
    begin_date ,
    end_date
  FROM wrk_plane
  ) pln
WHERE ssd_name IS NOT NULL
AND manufacturer IS NOT NULL
AND long_name    IS NOT NULL
AND short_name   IS NOT NULL
AND begin_date   IS NOT NULL
AND end_date     IS NOT NULL;  
   END;
   
PROCEDURE WRK_CL_REGION AS
   BEGIN
    EXECUTE IMMEDIATE '  TRUNCATE TABLE cl_region;' ;
  
INSERT INTO cl_region
SELECT rn.structure_code AS region_num,
  rn.structure_desc     AS region_name
FROM
  (SELECT DISTINCT structure_code, structure_desc FROM wrk_geo_data
  ) rn
WHERE structure_code IS NOT NULL
AND structure_desc  IS NOT NULL ;
 
    
   END;
   
PROCEDURE WRK_CL_STATE AS
   BEGIN
    EXECUTE IMMEDIATE ' TRUNCATE TABLE cl_state;';
  
INSERT INTO cl_state
SELECT 
  st.state_num ,
  st.DEST_STATE_NM,
  st.country_num 
FROM
  (SELECT DISTINCT state_num , DEST_STATE_NM, country_num  FROM wrk_state
  ) st
WHERE state_num IS NOT NULL
AND  DEST_STATE_NM IS NOT NULL
AND country_num IS NOT NULL;
    
   END;
  
   END WRK_TO_CL_PKG;
  / 