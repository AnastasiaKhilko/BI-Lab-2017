CREATE TABLE dim_customers(
customer_id number primary key,
first_name varchar2(10),
last_name varchar2(10),
email varchar2(10),
address varchar2(10),
postal_code number,
phone varchar2(10),
city varchar2(10),
country_name varchar2(10),
region varchar2(10),
update_dt date
);