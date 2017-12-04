DROP TABLE cl_fct_orders;
CREATE TABLE cl_fct_orders
  (
	car_id number(8) not null,
	customer_id number(8) not null,
	shop_id number(10) not null,
	seller_id number(8) not null,
	order_code VARCHAR2 ( 200  ) not null,
    cost number(8) not null,
    minPrice number(8) not null,
    maxPrice number(8) not null,
    avgPrice number(8) not null,
    sdPrice number(8) not null,
    start_dt date not null
    );
  
  
GRANT SELECT ON cl_fct_orders TO bl_dm;

