--==============================================================
-- Table: t_ce_passengers
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_passengers', Object_Type=>'TABLE');


CREATE TABLE ce_passengers
  (
    passenger_id number,
    passenger_code     NUMBER,
    give_name    VARCHAR2(100),
    middle_name  VARCHAR2(30),
    last_name    VARCHAR2(100),
    city         VARCHAR2(100),
    country_abbr VARCHAR2(2),
    email        VARCHAR2(150),
    phone        VARCHAR2(50),
    birthday     DATE,
    CONSTRAINT ce_passengers_pk PRIMARY KEY (passenger_id)
  );