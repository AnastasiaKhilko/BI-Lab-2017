CREATE TABLE dim_hotels(
hotel_id number primary key,
hotel_name varchar2(10),
category_name varchar2(10),
category_desc varchar2(10),
address varchar2(10),
email varchar2(10),
postal_code number,
phone varchar2(10),
city varchar2(10),
country_name varchar2(10),
region varchar2(10),
update_dt date
);