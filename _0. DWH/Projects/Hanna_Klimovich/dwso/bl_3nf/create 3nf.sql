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

ALTER TABLE FLIGHT ADD CONSTRAINT airline_ID_FK FOREIGN KEY (airline_ID) REFERENCES Airline(airline_ID);
ALTER TABLE FLIGHT ADD CONSTRAINT pilot_ID_FK FOREIGN KEY (pilot_ID) REFERENCES Pilot(pilot_ID);
ALTER TABLE FLIGHT ADD CONSTRAINT plane_ID_FK FOREIGN KEY (plane_ID) REFERENCES plane(plane_ID);
ALTER TABLE FLIGHT ADD CONSTRAINT dep_info_ID_FK FOREIGN KEY (dep_info_ID) REFERENCES dep_info(dep_info_ID);
ALTER TABLE FLIGHT ADD CONSTRAINT arr_info_ID_ID_FK FOREIGN KEY (arr_info_ID) REFERENCES arr_info(arr_info_ID);


ALTER TABLE PLANE ADD CONSTRAINT pl_manufacturer_FK FOREIGN KEY (manufacturer_id) REFERENCES pl_manufacturer(manufacturer_id);
ALTER TABLE PLANE ADD CONSTRAINT pl_status_FK FOREIGN KEY (status_id) REFERENCES pl_status(status_id);
ALTER TABLE PLANE ADD CONSTRAINT pl_role_FK FOREIGN KEY (role_id) REFERENCES pl_role(role_id);

ALTER TABLE city ADD CONSTRAINT origin_state_id_FK FOREIGN KEY (origin_state_id) REFERENCES state(origin_state_id);
ALTER TABLE state ADD CONSTRAINT country_FK FOREIGN KEY (origin_country_id) REFERENCES country(origin_country_id);


ALTER TABLE plane ADD CONSTRAINT origin_city_id_ailkine_FK FOREIGN KEY (origin_country_id) REFERENCES country(origin_country_id);

ALTER TABLE pilot ADD CONSTRAINT origin_city_pilot_FK FOREIGN KEY (origin_country_id) REFERENCES country(origin_country_id);
ALTER TABLE flight ADD CONSTRAINT origin_city_flight_FK FOREIGN KEY (origin_city_id) REFERENCES city(origin_city_id);
ALTER TABLE airline ADD CONSTRAINT origin_city_airline_FK FOREIGN KEY (origin_city_id) REFERENCES city(origin_city_id);