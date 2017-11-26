--==============================================================
-- Table: t_wrk_payments
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_payments', Object_Type=>'TABLE');

CREATE TABLE wrk_payments
  (
    payment_code       VARCHAR2(15),
    service_class_name VARCHAR2(100),
    route_code         VARCHAR2(10),
    price              VARCHAR2(100)
  );
  