CREATE TABLE dim_hotels(
hotel_id number primary key,
hotel_name varchar2(10),
category_id number references dim_categories(category_id),
address_id number references dim_addresses(address_id),
email varchar2(10),
update_dt date
);