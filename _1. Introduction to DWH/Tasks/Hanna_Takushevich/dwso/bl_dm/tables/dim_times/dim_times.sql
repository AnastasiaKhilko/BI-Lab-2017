CREATE TABLE dim_times (
    time_id       NUMBER,
    hours         NUMBER,
    minutes       NUMBER,
    description   VARCHAR2(5),
    CONSTRAINT dim_times_pk PRIMARY KEY ( time_id )
);