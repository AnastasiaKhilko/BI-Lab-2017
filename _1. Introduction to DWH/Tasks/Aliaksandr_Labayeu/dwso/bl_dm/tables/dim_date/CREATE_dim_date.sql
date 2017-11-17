CREATE TABLE dim_date (
  Full_date DATE PRIMARY KEY,
  Day_Week NUMBER(1),
  DAY_short VARCHAR(20),
  DAY_long VARCHAR2(20),
  DAY_month NUMBER(2),
  LastDay_month DATE,
  DAY_YEAR NUMBER(3),
  MONTH_year NUMBER(2),
  MONTH_short VARCHAR2(20),
  MONTH_long VARCHAR2(20),
  MONTH_desc VARCHAR(20),
  Quarter NUMBER(1),
  YEAR_half NUMBER(1),
  YEAR NUMBER(4)
);