CREATE OR REPLACE PACKAGE CL_TO_CE_PKG AS 
PROCEDURE cl_ce_airlines;
PROCEDURE cl_ce_country;
PROCEDURE cl_ce_pilot;
PROCEDURE cl_ce_plane;
PROCEDURE cl_ce_region;
PROCEDURE cl_ce_state;
PROCEDURE cl_ce_flight;
   END;
  / 
  
CREATE OR REPLACE PACKAGE body  CL_TO_CE_PKG AS  
PROCEDURE CL_CE_AIRLINES AS
   BEGIN
    MERGE INTO bl_3nf.ce_airlines CEAIR USING
(SELECT  Airline_ID ,
      a_name ,
      ICAO ,
      Active
FROM bl_cl.CL_airlines
MINUS
SELECT  Airline_ID ,
      a_name ,
      ICAO ,
      is_Active
FROM bl_3nf.ce_airlines
) CLAIR ON (CLAIR.airline_ID = CEAIR.airline_ID)
WHEN MATCHED THEN
  UPDATE SET CEAIR.a_name = CLAIR.a_name WHEN NOT MATCHED THEN
  INSERT
    (
      airlines_id_seq,
      Airline_ID ,
      a_name ,
      ICAO ,
      is_Active
    )
    VALUES
    (
      bl_3nf.airlines_SEQ.NEXTVAL,
      CLAIR.Airline_ID ,
      CLAIR.a_name ,
      CLAIR.ICAO ,
      CLAIR.Active
    );
  COMMIT;
   END;
   
   PROCEDURE CL_CE_country AS
   BEGIN
   MERGE INTO bl_3nf.ce_country nf USING
  (SELECT ctr.country_num ,
    ctr.country_name,
    rg.region_id_seq
  FROM bl_cl.CL_country ctr
  LEFT JOIN bl_3nf.CE_REGION rg
  ON ctr.region_num=rg.region_num
  MINUS
  SELECT ctr.country_num ,
    ctr.country_name,
    region_id
  FROM bl_3nf.ce_country ctr
  ) cl ON (nf.country_num = cl.country_num)
WHEN MATCHED THEN
  UPDATE SET nf.country_name = cl.country_name WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.country_seq.NEXTVAL,
      cl.country_num ,
      cl.country_name,
      cl.region_id_seq
    );
    EXECUTE IMMEDIATE '  commit;';
   END;
   
   PROCEDURE CL_CE_pilot AS
   BEGIN
   MERGE INTO bl_3nf.ce_pilot CEP USING
(SELECT pilot_id ,
  national_id ,
  p_name ,
  surname ,
  gender ,
  age ,
  hours_in_air
FROM bl_cl.CL_pilot
MINUS
SELECT pilot_id ,
  national_id ,
  p_name ,
  surname ,
  gender ,
  age ,
  hours_in_air
FROM bl_3nf.ce_pilot
) CLSC ON (CLSC.pilot_ID = CEP.pilot_ID)
WHEN MATCHED THEN
  UPDATE SET CEP.p_name = CLSC.p_name WHEN NOT MATCHED THEN
  INSERT
    (
      pilot_id_seq,
      pilot_id ,
      national_id ,
      p_name ,
      surname ,
      gender ,
      age ,
      hours_in_air
    )
    VALUES
    (
      bl_3nf.pilot_SEQ.NEXTVAL,
      CLSC.pilot_id ,
      CLSC.national_id ,
      CLSC.p_name ,
      CLSC.surname ,
      CLSC.gender ,
      CLSC.age ,
      CLSC.hours_in_air
    ); 
    EXECUTE IMMEDIATE '  commit;';
   END;
   
   PROCEDURE CL_CE_plane AS
   BEGIN
    MERGE INTO bl_3nf.ce_plane CEP USING
(SELECT model_name ,
    manufacturer ,
    long_name  ,
    short_name ,
    begin_date ,
    end_date   
FROM bl_cl.CL_PLANE
MINUS
SELECT model_name ,
    manufacturer ,
    long_name  ,
    short_name ,
    begin_date ,
    end_date  
FROM bl_3nf.ce_plane
) CLSC ON (CLSC.model_name = CEP.model_name)
WHEN MATCHED THEN
  UPDATE SET CEP.long_name = CLSC.long_name WHEN NOT MATCHED THEN
  INSERT
    (
      plane_id_seq,
      model_name ,
    manufacturer ,
    long_name  ,
    short_name ,
    begin_date ,
    end_date  
    )
    VALUES
    (
      bl_3nf.plane_SEQ.NEXTVAL,
      CLSC.model_name ,
    CLSC.manufacturer ,
    CLSC.long_name  ,
    CLSC.short_name ,
    CLSC.begin_date ,
    CLSC.end_date  
    );
    EXECUTE IMMEDIATE '  commit;';
   END;
   
   PROCEDURE CL_CE_region AS
   BEGIN
MERGE INTO bl_3nf.ce_region CEP USING
(SELECT region_num , region_name
 FROM bl_cl.CL_region
MINUS
SELECT region_num , region_name FROM bl_3nf.ce_region ) CLSC ON (CLSC.region_num = CEP.region_num)
WHEN MATCHED THEN
  UPDATE SET CEP.region_name = CLSC.region_name WHEN NOT MATCHED THEN
  INSERT
    (
      region_id_seq ,
      region_num ,
      region_name
    )
    VALUES
    (
      bl_3nf.region_seq.NEXTVAL,
      CLSC.region_num ,
      CLSC.region_name
    );
    EXECUTE IMMEDIATE '  commit;';    
   END;
   
   PROCEDURE CL_CE_state AS
   BEGIN
   MERGE INTO bl_3nf.ce_state nf USING
  (SELECT ctr.state_num ,
    ctr.DEST_STATE_NM,
    rg.country_id_seq
  FROM bl_cl.CL_state ctr
  LEFT JOIN bl_3nf.CE_country rg
  ON ctr.country_num=rg.country_id_seq
  MINUS
  SELECT ctr.state_num ,
    ctr.DEST_STATE_NM,
    country_num
  FROM bl_3nf.ce_state ctr
  ) cl ON (nf.state_num = cl.state_num)
WHEN MATCHED THEN
  UPDATE SET nf.DEST_STATE_NM = cl.DEST_STATE_NM WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.state_seq.NEXTVAL,
      cl.state_num ,
      cl.DEST_STATE_NM,
      cl.country_id_seq
    ); 
    EXECUTE IMMEDIATE '  commit;';
   END;
   
   PROCEDURE CL_CE_flight AS
   BEGIN
    EXECUTE IMMEDIATE '  ';
   INSERT INTO bl_3nf.ce_flight
  SELECT bl_3nf.flight_seq.NEXTVAL,
    fl.f_YEAR ,
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
    FROM cl_flight
    ) fl
  WHERE F_YEAR      IS NOT NULL
  AND f_MONTH       IS NOT NULL
  AND DAY_OF_MONTH  IS NOT NULL
  AND TAIL_NUM      IS NOT NULL
  AND CARRIER       IS NOT NULL
  AND DEST_STATE_NM IS NOT NULL
  AND DEP_TIME      IS NOT NULL
  AND PLANE_ID      IS NOT NULL
  AND PILOT_ID      IS NOT NULL 
  ; 
   END;
   END CL_TO_CE_PKG;
  / 