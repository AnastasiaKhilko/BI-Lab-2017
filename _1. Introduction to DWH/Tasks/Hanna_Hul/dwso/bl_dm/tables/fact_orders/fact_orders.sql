CREATE TABLE fact_orders(
order_id number primary key,
customer_id number references dim_customers(customer_id),
order_date date,
hotel_id number references dim_hotels(hotel_id),
source_id number references dim_sources(source_id),
order_date_id number references dim_order_date(date_id),
check_in_date_id number references dim_checkin_date(date_id),
check_out_date_id number references dim_checkout_date(date_id),
amount number(10,2),
-- room_type
--class
number_of_people number(10,2),
discount number(10,2)
);