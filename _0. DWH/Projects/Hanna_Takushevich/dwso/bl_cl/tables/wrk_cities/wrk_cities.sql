--==============================================================
-- Table: t_wrk_cities
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_cities', Object_Type=>'TABLE');

CREATE TABLE wrk_cities (
    cc_fips     VARCHAR2(2),
    city_name   VARCHAR2(200)
);