CREATE TABLE fact_purchaces
  (
    purchace_id           NUMBER,
    flight_surr_id        NUMBER,
    passenger_surr_id     NUMBER,
    airline_surr_id       NUMBER,
    service_class_surr_id NUMBER,
    purchace_date         DATE,
    airport_to_surr_id    NUMBER,
    airport_from_surr_id  NUMBER,
    price                 NUMBER,
    insert_dt             DATE DEFAULT sysdate,
    
    CONSTRAINT purch_passenger_fk FOREIGN KEY ( passenger_surr_id ) REFERENCES dim_passengers ( passenger_surr_id ),
    CONSTRAINT purch_flight_fk FOREIGN KEY ( flight_surr_id ) REFERENCES dim_flights ( flight_surr_id ),
    CONSTRAINT purch_airport_to_fk FOREIGN KEY ( airport_to_surr_id ) REFERENCES dim_airports ( airport_surr_id ),
    CONSTRAINT purch_airport_from_fk FOREIGN KEY ( airport_from_surr_id ) REFERENCES dim_airports ( airport_surr_id ),
    CONSTRAINT purch_date_fk FOREIGN KEY ( purchace_date ) REFERENCES dim_date ( date_id ),
    CONSTRAINT purch_serv_fk FOREIGN KEY ( service_class_surr_id ) REFERENCES dim_service_classes_scd ( service_class_surr_id ),
    CONSTRAINT purch_airline_fk FOREIGN KEY ( airline_surr_id ) REFERENCES dim_airlines ( airline_surr_id )
  )PARTITION BY RANGE (purchace_date)
  (PARTITION t1p1 VALUES LESS THAN (TO_DATE('01-jan-2015', 'dd-mon-yy')),
   PARTITION t1p2 VALUES LESS THAN (TO_DATE('01-jan-2016', 'dd-mon-yy')),
   PARTITION t1p3 VALUES LESS THAN (TO_DATE('01-jan-2017', 'dd-mon-yy')),
   PARTITION t1p4 VALUES LESS THAN (TO_DATE('01-jan-2018', 'dd-mon-yy'))--,
  -- PARTITION t1p5 VALUES LESS THAN (MAXVALUE)
  );