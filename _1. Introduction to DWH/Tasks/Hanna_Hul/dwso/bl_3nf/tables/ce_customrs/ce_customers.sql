CREATE TABLE dim_customers(
customer_id number primary key,
first_name varchar2(10),
last_name varchar2(10),
email varchar2(10),
address_id number references dim_addresses(address_id),
update_dt date
);