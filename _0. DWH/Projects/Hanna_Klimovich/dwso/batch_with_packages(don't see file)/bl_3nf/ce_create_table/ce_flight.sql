execute pckg_drop.DROP_Proc('ce_flight','TABLE');
execute pckg_drop.DROP_Proc('flight_seq','sequence');
CREATE TABLE ce_flight
  (
    flight_id_seq         NUMBER PRIMARY KEY NOT NULL,
    f_YEAR                NUMBER NOT NULL,
    f_MONTH               NUMBER NOT NULL,
    DAY_OF_MONTH          NUMBER NOT NULL,
    DAY_OF_WEEK           NUMBER,
    FL_DATE               DATE,
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
CREATE sequence flight_seq start with 1 increment BY 1 nocache nocycle;
ALTER TABLE ce_flight ADD CONSTRAINT carrier_id_FK FOREIGN KEY (carrier) REFERENCES ce_airlines(ICAO);
ALTER TABLE ce_flight ADD CONSTRAINT pilot_id_FK FOREIGN KEY (pilot_id) REFERENCES ce_pilot (PILOT_ID_SEQ);
ALTER TABLE ce_flight ADD CONSTRAINT plane_id_FK FOREIGN KEY (plane_id) REFERENCES ce_plane (Plane_ID_SEQ);
ALTER TABLE ce_flight ADD CONSTRAINT state_id_FK FOREIGN KEY (DEST_STATE_NM) REFERENCES ce_state (state_id_seq);