/*-------------
--CL_GENDER--
-------------
CREATE TABLE cl_gender
( gender VARCHAR2(200 CHAR)
);
drop table cl_gender;*/
------------
--CL_PILOT--
------------
CREATE TABLE cl_pilot
  (
    pilot_id     NUMBER NOT NULL,
    national_id  VARCHAR2 (200 CHAR),
    p_name       VARCHAR2(200 CHAR),
    surname      VARCHAR2(200 CHAR),
    gender       VARCHAR2(200 CHAR),
    age          NUMBER,
    hours_in_air NUMBER
  );
----------------
---CL_COUNTRY---
----------------
CREATE TABLE cl_country
  (
    country_num  NUMBER,
    country_name VARCHAR2 (200 CHAR),
    region_num NUMBER
  );
drop table cl_country;
----------------
---CL_REGION----
----------------
CREATE TABLE cl_region
  (
    region_num  NUMBER,
    region_name VARCHAR2 (200 CHAR)
  );
/*----------------------
---CL_MANUFACTURER----
----------------------
CREATE TABLE cl_manufacturer
(
manufacturer_name VARCHAR2 (200 CHAR)
);
*/
CREATE TABLE cl_plane
  (
    model_name VARCHAR2 (200 CHAR) NOT NULL,
    manufacturer VARCHAR2 (200 CHAR)NOT NULL,
    long_name  VARCHAR2 (200 CHAR),
    short_name VARCHAR2 (200 CHAR),
    begin_date VARCHAR2 (200 CHAR),
    end_date   VARCHAR2 (200 CHAR)
  );