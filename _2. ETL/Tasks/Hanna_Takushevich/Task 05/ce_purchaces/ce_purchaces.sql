--==============================================================
-- Table: t_ce_purchaces
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_purchaces', Object_Type=>'TABLE');
CREATE TABLE ce_purchaces
  (
    purchace_id   NUMBER,
    flight_id     NUMBER,
    payment_id    NUMBER,
    passenger_id  NUMBER,
    purchace_date DATE,
    insert_dt     DATE DEFAULT sysdate,
    CONSTRAINT ce_purchace_pk PRIMARY KEY (purchace_id),
    CONSTRAINT purchace_flight_fk FOREIGN KEY (flight_id) REFERENCES ce_flights (flight_id),
    CONSTRAINT purchace_payment_fk FOREIGN KEY (payment_id) REFERENCES ce_payments (payment_id),
    CONSTRAINT purchace_passenger_fk FOREIGN KEY (passenger_id) REFERENCES ce_passengers (passenger_id)
  );