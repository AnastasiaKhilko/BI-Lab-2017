--==============================================================
-- Table: t_wrk_routes
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_routes', Object_Type=>'TABLE');
CREATE TABLE wrk_routes
  (
    route_code        VARCHAR2(10),
    airport_name_from VARCHAR2(150),
    country_from      VARCHAR2(200),
    airport_name_to   VARCHAR2(150),
    country_to        VARCHAR2(200)
  );