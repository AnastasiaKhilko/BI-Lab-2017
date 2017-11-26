--==============================================================
-- Table: t_wrk_passengers
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_passengers', Object_Type=>'TABLE');

CREATE TABLE wrk_passengers
  (
    num_pass     VARCHAR2(10),
    give_name    VARCHAR2(100),
    middle_name  VARCHAR2(30),
    last_name    VARCHAR2(100),
    city         VARCHAR2(100),
    country_abbr VARCHAR2(6),
    email        VARCHAR2(150),
    phone        VARCHAR2(50),
    birthday     VARCHAR2(30)
  );