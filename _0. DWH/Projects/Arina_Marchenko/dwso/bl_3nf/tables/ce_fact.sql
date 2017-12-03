DROP TABLE ce_orders;
CREATE TABLE ce_orders
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
      start_dt date not null,
      end_dt date not null
  );
  
  
GRANT SELECT ON bl_3nf.ce_orders TO bl_cl;

ALTER TABLE ce_orders ADD CONSTRAINT ce_orders_pk PRIMARY KEY (car_id, customer_id, shop_id, seller_id, order_code);
ALTER TABLE ce_orders ADD CONSTRAINT fk_ce_cars FOREIGN KEY (car_id) REFERENCES ce_cars(car_id);
ALTER TABLE ce_orders ADD CONSTRAINT fk_ce_customer FOREIGN KEY (customer_id) REFERENCES ce_customers(customer_id);
ALTER TABLE ce_orders ADD CONSTRAINT fk_ce_shop FOREIGN KEY (shop_id) REFERENCES ce_shop(shop_id);
ALTER TABLE ce_orders ADD CONSTRAINT fk_ce_seller FOREIGN KEY (seller_id) REFERENCES ce_seller(seller_id);
GRANT SELECT, INSERT, DELETE, UPDATE ON ce_orders TO bl_cl;
  GRANT SELECT ON ce_orders to bl_cl_dm;