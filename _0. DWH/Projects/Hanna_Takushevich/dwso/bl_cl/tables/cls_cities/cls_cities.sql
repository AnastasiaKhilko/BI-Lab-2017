--==============================================================
-- Table: t_cls_cities
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_cities', Object_Type=>'TABLE');

CREATE TABLE cls_cities (
    cc_fips     VARCHAR2(2),
    city_name   VARCHAR2(200)
);