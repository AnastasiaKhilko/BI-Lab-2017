CREATE TABLE ce_payments
  (
    payment_id       NUMBER,
    service_class_id NUMBER,
    route_id         NUMBER,
    price            NUMBER(10,2),
    CONSTRAINT ce_payment_pk PRIMARY KEY (payment_id),
    CONSTRAINT payment_service_class_fk FOREIGN KEY (service_class_id) REFERENCES ce_service_classes (service_class_id),
    CONSTRAINT payment_route_fk FOREIGN KEY (route_id) REFERENCES ce_routes (route_id)
  );