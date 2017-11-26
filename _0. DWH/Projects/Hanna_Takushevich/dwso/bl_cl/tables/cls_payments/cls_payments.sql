--==============================================================
-- Table: t_cls_payments
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_payments', Object_Type=>'TABLE');

CREATE TABLE cls_payments
  (
    payment_code       NUMBER,
    service_class_name VARCHAR2(100),
    route_code         VARCHAR2(3),
    price              NUMBER
  );