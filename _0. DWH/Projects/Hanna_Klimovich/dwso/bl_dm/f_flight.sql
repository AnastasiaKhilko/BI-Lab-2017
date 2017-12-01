/**===============================================*\Name...............:   f_flight
Contents...........:   fact creation
Author.............:   Hanna Klimovich
Date...............:   30.11.2017
\*=============================================== */
---DROP TABLE f_flight;
CREATE TABLE f_flight
  (
    f_YEAR                NUMBER NOT NULL,
    f_MONTH               NUMBER NOT NULL,
    DAY_OF_MONTH          NUMBER NOT NULL,
    DAY_OF_WEEK           NUMBER,
    FL_DATE               VARCHAR2(200 CHAR),
    UNIQUE_CARRIER        VARCHAR2(200 CHAR),
    AIRLINE_ID            NUMBER,
    CARRIER               VARCHAR2(10 CHAR) NOT NULL,
    TAIL_NUM              VARCHAR2(20 CHAR)NOT NULL,
    FL_NUM                NUMBER NOT NULL,
    ORIGIN_AIRPORT_ID     NUMBER,
    ORIGIN_AIRPORT_SEQ_ID NUMBER,
    ORIGIN_CITY_MARKET_ID NUMBER,
    ORIGIN                VARCHAR2(8 CHAR),
    ORIGIN_CITY_NAME      VARCHAR2(200 CHAR),
    ORIGIN_STATE_ABR      VARCHAR2(5 CHAR),
    ORIGIN_STATE_NM       VARCHAR2(200 CHAR),
    ORIGIN_WAC            NUMBER,
    DEST_AIRPORT_ID       NUMBER,
    DEST_AIRPORT_SEQ_ID   NUMBER,
    DEST_CITY_MARKET_ID   NUMBER,
    DEST                  VARCHAR2(8 CHAR),
    DEST_CITY_NAME        VARCHAR2(200 CHAR),
    DEST_STATE_ABR        VARCHAR2(5 CHAR),
    DEST_STATE_NM         NUMBER NOT NULL,
    CRS_DEP_TIME          NUMBER,
    DEP_TIME              NUMBER NOT NULL,
    DEP_DELAY             NUMBER,
    DEP_DELAY_NEW         NUMBER,
    DEP_DEL15             NUMBER,
    CRS_ARR_TIME          NUMBER,
    ARR_TIME              NUMBER,
    ARR_DELAY             NUMBER,
    ARR_DELAY_NEW         NUMBER,
    ARR_DEL15             NUMBER,
    CRS_ELAPSED_TIME      NUMBER,
    ACTUAL_ELAPSED_TIME   NUMBER,
    AIR_TIME              NUMBER,
    FLIGHTS               NUMBER,
    DISTANCE              NUMBER,
    DISTANCE_GROUP        NUMBER,
    PLANE_ID              NUMBER NOT NULL,
    PILOT_ID              NUMBER NOT NULL
  ) ;
INSERT INTO F_FLIGHT
SELECT f_YEAR ,
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
FROM bl_3nf.ce_flight;

ALTER TABLE f_flight ADD CONSTRAINT carrier_id_FK FOREIGN KEY (carrier) REFERENCES dm_airlines(icao);
ALTER TABLE f_flight ADD CONSTRAINT pilot_id_FK FOREIGN KEY (pilot_id) REFERENCES dm_pilot (PILOT_ID_SEQ);
ALTER TABLE f_flight ADD CONSTRAINT plane_id_FK FOREIGN KEY (plane_id) REFERENCES dm_plane (Plane_ID_SEQ);
ALTER TABLE f_flight ADD CONSTRAINT state_id_FK FOREIGN KEY (DEST_STATE_NM) REFERENCES dm_location (state_num);
--ALTER TABLE f_flight ADD CONSTRAINT PK_CONST PRIMARY KEY(FL_DATE,carrier,pilot_id,plane_id,DEST_STATE_NM);
COMMENT ON TABLE f_flight
IS
  'Table Content: Describe content of a table.     
Refresh Cycle/Window: This is a fact table!';
--GRANT SELECT ON f_flight TO new_user;
  COMMIT; 