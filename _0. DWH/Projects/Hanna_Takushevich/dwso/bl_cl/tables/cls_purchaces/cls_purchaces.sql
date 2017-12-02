--==============================================================
-- Table: t_cls_purchaces
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_purchaces', Object_Type=>'TABLE');
CREATE TABLE cls_purchaces
  (
    flight_id     NUMBER,
    payment_id    NUMBER,
    passenger_id  NUMBER,
    purchace_date DATE
  );