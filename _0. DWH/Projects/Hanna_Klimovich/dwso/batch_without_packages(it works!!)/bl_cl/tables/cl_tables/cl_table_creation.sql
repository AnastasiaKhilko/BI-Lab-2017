------------
--CL_PILOT--
------------
execute pckg_drop.DROP_Proc('cl_pilot','TABLE');
CREATE TABLE cl_pilot
  (
    pilot_id     NUMBER NOT NULL,
    national_id  VARCHAR2 (200 CHAR),
    p_name       VARCHAR2(200 CHAR),
    surname      VARCHAR2(200 CHAR),
    gender       VARCHAR2(200 CHAR),
    age          NUMBER,
    hours_in_air NUMBER,
    begin_date   VARCHAR2 (200 CHAR),
    end_date     VARCHAR2 (200 CHAR)
  );
----------------
----CL_STATE----
----------------
execute pckg_drop.DROP_Proc('cl_state','TABLE');
CREATE TABLE cl_state
  (
    state_num	NUMBER NOT NULL,
    DEST_STATE_NM VARCHAR2 ( 200 CHAR ) NOT NULL,
    country_num NUMBER NOT NULL
  );
----------------
---CL_COUNTRY---
----------------
execute pckg_drop.DROP_Proc('cl_country','TABLE');
CREATE TABLE cl_country
  (
    country_num  NUMBER,
    country_name VARCHAR2 (200 CHAR),
    region_num   NUMBER
  );
----------------
---CL_REGION----
----------------
execute pckg_drop.DROP_Proc('cl_region','TABLE');
CREATE TABLE cl_region
  ( region_num NUMBER, region_name VARCHAR2 (200 CHAR)
  );
/*----------------------
---CL_MANUFACTURER----
----------------------
CREATE TABLE cl_manufacturer
(
manufacturer_name VARCHAR2 (200 CHAR)
);
*/
----------------
---CL_PLANE----
----------------
execute pckg_drop.DROP_Proc('cl_plane','TABLE');
CREATE TABLE cl_plane
  (
    model_name   VARCHAR2 (200 CHAR) NOT NULL,
    manufacturer VARCHAR2 (200 CHAR)NOT NULL,
    long_name    VARCHAR2 (200 CHAR),
    short_name   VARCHAR2 (200 CHAR),
    begin_date   VARCHAR2 (200 CHAR),
    end_date     VARCHAR2 (200 CHAR)
  );
----------------
---CL_AIRLINES--
----------------
execute pckg_drop.DROP_Proc('cl_airlines','TABLE');
CREATE TABLE cl_airlines
  (
    Airline_ID NUMBER NOT NULL,
    a_name     VARCHAR2 ( 200 CHAR )NOT NULL,
    ICAO       VARCHAR2 ( 10 CHAR )NOT NULL,
    Active     VARCHAR2 ( 10 CHAR )
  );
----------------
---CL_FLIGHT---
----------------
execute pckg_drop.DROP_Proc('cl_flight','TABLE');
CREATE TABLE cl_flight
  (
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
