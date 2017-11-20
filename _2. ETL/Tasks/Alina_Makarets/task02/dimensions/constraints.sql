ALTER TABLE dim_customers 
ADD CONSTRAINT PK_customer_id PRIMARY KEY (customer_id);

ALTER TABLE dim_products
ADD CONSTRAINT PK_product_id PRIMARY KEY (product_id);

ALTER TABLE dim_stores 
ADD CONSTRAINT PK_store_id PRIMARY KEY (store_id);

