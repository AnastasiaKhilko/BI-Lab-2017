--==============================================================
-- Table: t_cls_routes
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_routes', Object_Type=>'TABLE');
CREATE TABLE cls_routes
  (
    route_code        VARCHAR2(10),
    airport_name_from VARCHAR2(150),
    airport_name_to   VARCHAR2(150)
  );