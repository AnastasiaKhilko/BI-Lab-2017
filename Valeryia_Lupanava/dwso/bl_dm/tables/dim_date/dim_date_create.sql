CREATE TABLE dim_date (
    start_date               DATE,
    week_day_full_name       VARCHAR2(10),
    week_day_short_name      VARCHAR2(10),
    day_number_of_week       NUMBER(10),
    day_number_of_month      NUMBER(10),
    day_number_of_year       NUMBER(10),
    month_year               VARCHAR2(10),
    month_full_name          VARCHAR2(10),
    month_short_name         VARCHAR2(10),
    month_number_of_year     NUMBER(10),
    quarter_year             VARCHAR2(10),
    quarter_number_of_year   VARCHAR2(10),
    half_year_number         VARCHAR2(10),
    half_year                VARCHAR2(10),
    year                     VARCHAR2(10),
    CONSTRAINT start_date_pk PRIMARY KEY ( start_date )
);