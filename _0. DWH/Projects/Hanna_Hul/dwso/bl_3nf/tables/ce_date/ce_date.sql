CREATE TABLE dim_date(
date_id number primary key,
year_ number,
month_ number,
english_month_name varchar2(10),
day_of_month number,
day_of_year number,
day_of_week_name varchar2(10)
);