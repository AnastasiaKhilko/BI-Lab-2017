ALTER TABLE products ADD CONSTRAINT fk_cat FOREIGN KEY(category_id) REFERENCES category(category_id);
ALTER TABLE stores ADD CONSTRAINT fk_coun FOREIGN KEY(country_sur_id) REFERENCES test_ce_countries(country_sur_id);
ALTER TABLE fct_sales ADD CONSTRAINT fk_date FOREIGN KEY(event_dt) REFERENCES dim_time_day(full_date_dt);
ALTER TABLE products ADD CONSTRAINT pk_product PRIMARY KEY(product_id) ;
ALTER TABLE fct_sales ADD CONSTRAINT fk_product FOREIGN KEY(product_id) REFERENCES products(product_id);
ALTER TABLE employees ADD CONSTRAINT pk_emp PRIMARY KEY(employee_id) ;
ALTER TABLE fct_sales ADD CONSTRAINT fk_emp FOREIGN KEY(employee_id) REFERENCES employees(employee_id);
ALTER TABLE stores ADD CONSTRAINT pk_st PRIMARY KEY(store_id) ;
ALTER TABLE fct_sales ADD CONSTRAINT fk_stp FOREIGN KEY(store_id) REFERENCES stores(store_id);
