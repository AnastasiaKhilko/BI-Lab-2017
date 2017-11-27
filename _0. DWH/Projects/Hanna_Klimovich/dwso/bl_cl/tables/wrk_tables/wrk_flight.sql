--==============================================================
-- Table: wrk_flight
--==============================================================
DROP TABLE wrk_flight;
CREATE TABLE wrk_flight
  (
    f_YEAR                NUMBER,
    QUARTER               NUMBER,
    f_MONTH               NUMBER,
    DAY_OF_MONTH          NUMBER,
    DAY_OF_WEEK           NUMBER,
    FL_DATE               VARCHAR2(200 CHAR),
    UNIQUE_CARRIER        VARCHAR2(200 CHAR),
    AIRLINE_ID            NUMBER,
    CARRIER               VARCHAR2(10 CHAR),
    TAIL_NUM              VARCHAR2(20 CHAR),
    FL_NUM                NUMBER,
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
    DEST_STATE_NM         VARCHAR2(200 CHAR),
    CRS_DEP_TIME          NUMBER,
    DEP_TIME              NUMBER,
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
    CARRIER_DELAY         NUMBER,
    WEATHER_DELAY         NUMBER,
    NAS_DELAY             NUMBER,
    SECURITY_DELAY        NUMBER,
    LATE_AIRCRAFT_DELAY   NUMBER
  ) ;
TRUNCATE TABLE wrk_flight;
INSERT INTO wrk_flight
SELECT * FROM sa_src.ext_flight;
