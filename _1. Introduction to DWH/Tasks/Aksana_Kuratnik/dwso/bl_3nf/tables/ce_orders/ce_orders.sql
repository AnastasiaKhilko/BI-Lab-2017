CREATE TABLE orders
  (
    order_id  NUMBER(8) PRIMARY KEY,
    Date_id            date NOT NULL,
    Customer_id        number(8) NOT NULL,
    Seller_id        number(8) NOT NULL,
    Stock_id           number(8) NOT NULL,
    Product_id         varchar(8) NOT NULL,
    Payment_method_id         number(8) NOT NULL,
    Delivery_method_id   number(8) NOT NULL,
    Amount            NUMBER(5) NOT NULL,
    CONSTRAINT fk_date FOREIGN KEY (date_id) REFERENCES ddate(date_id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_seller FOREIGN KEY (seller_id) REFERENCES sellers(seller_id),
    CONSTRAINT fk_stock FOREIGN KEY (stock_id) REFERENCES stocks(stock_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT fk_payment FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id),
    CONSTRAINT fk_delivery FOREIGN KEY (delivery_method_id) REFERENCES delivery_methods(delivery_method_id)
  );

