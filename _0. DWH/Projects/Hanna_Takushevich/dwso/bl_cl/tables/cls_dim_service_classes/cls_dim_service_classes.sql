--==============================================================
-- Table: t_cls_dim_service_classes
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_dim_service_classes', Object_Type=>'TABLE');
CREATE TABLE cls_dim_service_classes AS
SELECT class_id AS service_class_id,
  class_code    AS service_class_code,
  class_name    AS service_class_name,
  seat_letter,
  menu,
  max_luggage,
  class_desc AS service_class_desc,
  start_dt,
  end_dt,
  is_active,
  insert_dt
FROM ce_service_classes;