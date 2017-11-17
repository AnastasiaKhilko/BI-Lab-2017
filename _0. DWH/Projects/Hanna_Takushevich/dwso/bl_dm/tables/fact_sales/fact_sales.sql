CREATE TABLE fact_sales (
    passenger_id       NUMBER,
    flight_id          NUMBER,
    service_class_id   NUMBER,
    time_id            NUMBER,
    destination_id     NUMBER,
    departure_id       NUMBER,
    purchase_date_id   DATE,
    price              NUMBER,
    seat_letter        VARCHAR2(1),
    seat_number        NUMBER,
    CONSTRAINT sales_passenger_fk FOREIGN KEY ( passenger_id )
        REFERENCES dim_passengers ( passenger_id ),
    CONSTRAINT sales_flight_fk FOREIGN KEY ( flight_id )
        REFERENCES dim_flights ( flight_id ),
    CONSTRAINT sales_servclass_fk FOREIGN KEY ( service_class_id )
        REFERENCES dim_service_classes ( service_class_id ),
    CONSTRAINT sales_time_fk FOREIGN KEY ( time_id )
        REFERENCES dim_times ( time_id ),
    CONSTRAINT sales_airport_des_fk FOREIGN KEY ( destination_id )
        REFERENCES dim_airports ( airport_id ),
    CONSTRAINT sales_airport_dep_fk FOREIGN KEY ( departure_id )
        REFERENCES dim_airports ( airport_id ),
    CONSTRAINT sales_date_fk FOREIGN KEY ( purchase_date_id )
        REFERENCES dim_date ( date_id )
);