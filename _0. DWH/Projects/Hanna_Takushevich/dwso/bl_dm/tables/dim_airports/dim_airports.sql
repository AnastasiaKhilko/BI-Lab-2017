--==============================================================
-- Table: t_dim_airports
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'dim_airports', Object_Type=>'TABLE');
CREATE TABLE dim_airports
  (
    airport_surr_id number primary key,
    airport_id number, 
    city_id number, 
    airport_name varchar2(150), 
    airport_iata varchar2(3), 
    airport_icao varchar2(4), 
    airport_faa varchar2(5), 
    city_name varchar2(200), 
    country_name varchar2(200), 
    subregion_name varchar2(200), 
    region_name varchar2(25),
    insert_dt date default sysdate,
    update_dt date default sysdate
  );