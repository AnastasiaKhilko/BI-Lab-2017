CREATE TABLE dim_service_classes (
    service_class_id     NUMBER,
    service_class_name   VARCHAR2(30),
    seat_letter          VARCHAR2(1),
    menu                 VARCHAR2(100),
    max_luggage_kg       NUMBER,
    description          VARCHAR2(200),
    start_dt             DATE,
    end_dt               DATE,
    is_active            VARCHAR2(1),
    CONSTRAINT dim_service_classes_pk PRIMARY KEY ( service_class_id )
);