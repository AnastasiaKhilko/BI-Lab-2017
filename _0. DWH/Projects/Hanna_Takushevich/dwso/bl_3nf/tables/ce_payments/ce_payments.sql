--==============================================================
-- Table: t_ce_payments
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_payments', Object_Type=>'TABLE');
CREATE TABLE ce_payments
  (
    payment_id       NUMBER,
    payment_code     NUMBER,
    service_class_id NUMBER,
    route_id         NUMBER,
    price            NUMBER,
    insert_dt        DATE DEFAULT sysdate,
    update_dt        DATE DEFAULT sysdate,
    CONSTRAINT ce_payment_pk PRIMARY KEY (payment_id),
    CONSTRAINT payment_class_fk FOREIGN KEY (service_class_id) REFERENCES ce_service_classes (class_id),
    CONSTRAINT payment_route_fk FOREIGN KEY (route_id) REFERENCES ce_routes (route_id)
  );