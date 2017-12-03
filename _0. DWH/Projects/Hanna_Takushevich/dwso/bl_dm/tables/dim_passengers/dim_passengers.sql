--==============================================================
-- Table: t_dim_passengers
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'dim_passengers', Object_Type=>'TABLE');
CREATE TABLE dim_passengers
  (
    passenger_surr_id NUMBER PRIMARY KEY,
    passenger_id      NUMBER NOT NULL,
    passenger_code    NUMBER NOT NULL,
    given_name        VARCHAR2(100),
    middle_name       VARCHAR2(30),
    last_name         VARCHAR2(100),
    city              VARCHAR2(100),
    country_abbr      VARCHAR2(2),
    email             VARCHAR2(150),
    phone             VARCHAR2(50),
    birthday          DATE,
    insert_dt         DATE,
    update_dt         DATE
  );