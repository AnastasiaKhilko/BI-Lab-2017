CREATE TABLE dim_countries(
country_id number primary key,
country_code varchar2(10),
country_name varchar2(10),
region_id number references dim_regions(region_id),
update_dt date
);