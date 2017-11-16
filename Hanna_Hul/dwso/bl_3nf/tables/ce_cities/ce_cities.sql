CREATE TABLE dim_cities(
city_id number primary key,
city varchar2(10),
country_id number references dim_countries (country_id),
update_dt date
);