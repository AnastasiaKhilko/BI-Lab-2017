CREATE TABLE Airline 
(airline_id number primary key, 
airline_name VARCHAR2 (70),
iata VARCHAR2 (8), 
icao varchar2 (8),
slogan varchar2 (100), 
origin_city_id number, 
number_employees number,
website varchar2 (60),
founded_year number
);

CREATE TABLE pilot (
pilot_id number primary key, 
license_num number,
name varchar2 (50),
surname varchar2 (70),
full_name varchar2 (120),
yofb number,
origin_country_id number,
hours_in_air number,
START_DT                 DATE          NOT NULL,
END_DT                 DATE          NOT NULL,
IS_ACTIVE              VARCHAR2(4)   NOT NULL
);

CREATE TABLE plane (
plane_id number primary key,
plane_name varchar2 (50),
role_id number,
origin_country_id number,
manufacturer_id number,
status_id number,
number_built number,
START_DT                 DATE          NOT NULL,
END_DT                 DATE          NOT NULL,
IS_ACTIVE              VARCHAR2(4)   NOT NULL
);

CREATE TABLE pl_manufacturer (
manufacturer_id number primary key,
manufacturer_name VARCHAR2 (100)
);

CREATE TABLE pl_status (
status_id number primary key,
status varchar2 (20)
);

CREATE TABLE pl_role (
role_id number primary key,
role varchar2 (20)
);

CREATE TABLE city (
origin_city_id number primary key,
origin_city VARCHAR2 (70),
origin_state_id number
);

CREATE TABLE state (
origin_state_id number primary key,
origin_state varchar2 (70), 
origin_country_id number
);

CREATE TABLE country (
origin_country_id number primary key,
origin_country varchar2 (70)
);

CREATE TABLE dep_info (
dep_info_id number primary key,
crs_dep_time number,
dep_time number,
dep_delay number,
dep_delay_15  number
);

CREATE TABLE arr_info (
arr_info_id number primary key,
crs_arr_time number,
arr_time number,
arr_delay number,
arr_delay_15  number
);

CREATE TABLE Flight (
flight_id number primary key,
fl_date date,
airline_id number,
pilot_id number,
plane_id number,
tail_num varchar2(7),
fl_num number,
origin_city_id number,
dep_info_id number,
arr_info_id number
);

