CREATE TABLE dim_tickets (
    ticket_id number,
    service_class_id     NUMBER,
    service_class_name   VARCHAR2(30),
    seat_letter          VARCHAR2(1),
    seat_number varchar2(3),
    menu                 VARCHAR2(100),
    max_luggage_kg       NUMBER,
    description          VARCHAR2(200),
    CONSTRAINT dim_ticket_pk PRIMARY KEY ( ticket_id )
);