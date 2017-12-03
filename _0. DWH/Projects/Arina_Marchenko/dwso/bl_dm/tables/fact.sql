DROP TABLE fct_orders;
CREATE TABLE fct_orders
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
GRANT SELECT ON bl_dm.fct_orders TO bl_cl_dm;

ALTER TABLE fct_orders ADD CONSTRAINT fct_orders_pk PRIMARY KEY (car_id, customer_id, shop_id, seller_id, order_code);
ALTER TABLE fct_orders ADD CONSTRAINT fk_dim_cars FOREIGN KEY (car_id) REFERENCES dim_cars(car_did);
ALTER TABLE fct_orders ADD CONSTRAINT fk_dim_customer FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_did);
ALTER TABLE fct_orders ADD CONSTRAINT fk_dim_shop FOREIGN KEY (shop_id) REFERENCES dim_shop(shop_did);
ALTER TABLE fct_orders ADD CONSTRAINT fk_dim_seller FOREIGN KEY (seller_id) REFERENCES dim_seller(seller_did);
ALTER TABLE fct_orders ADD CONSTRAINT fk_dim_date FOREIGN KEY (start_dt) REFERENCES dim_date(event_dt);
GRANT SELECT, INSERT, DELETE, UPDATE ON fct_orders TO bl_cl_dm;