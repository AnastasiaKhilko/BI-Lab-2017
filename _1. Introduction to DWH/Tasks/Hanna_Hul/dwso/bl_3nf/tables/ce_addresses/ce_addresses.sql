CREATE TABLE dim_addresses(
address_id number primary key,
address varchar2(10),
city_id number references dim_cities (city_id),
postal_code number,
phone varchar2(10),
update_dt date
);