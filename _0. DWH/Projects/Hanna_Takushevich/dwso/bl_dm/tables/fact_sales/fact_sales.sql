CREATE TABLE fact_sales (
    passenger_id       NUMBER,
    flight_id          NUMBER,
    ticket_id          NUMBER,
    destination_id     NUMBER,
    departure_id       NUMBER,
    purchase_date_id   DATE,
    airline_id         NUMBER,
    price              NUMBER,
    CONSTRAINT sales_passenger_fk FOREIGN KEY ( passenger_id )
        REFERENCES dim_passengers ( passenger_id ),
    CONSTRAINT sales_flight_fk FOREIGN KEY ( flight_id )
        REFERENCES dim_flights ( flight_id ),
    CONSTRAINT sales_ticket_fk FOREIGN KEY ( ticket_id )
        REFERENCES dim_tickets ( ticket_id ),
    CONSTRAINT sales_airport_des_fk FOREIGN KEY ( destination_id )
        REFERENCES dim_airports ( airport_id ),
    CONSTRAINT sales_airport_dep_fk FOREIGN KEY ( departure_id )
        REFERENCES dim_airports ( airport_id ),
    CONSTRAINT sales_date_fk FOREIGN KEY ( purchase_date_id )
        REFERENCES dim_dates ( date_id ),
    CONSTRAINT sales_airline_fk FOREIGN KEY ( airline_id )
        REFERENCES dim_airlines ( airline_id )
);
