CREATE TABLE products
  (
    Product_id          VARCHAR2(25) PRIMARY KEY,
    Product_name        VARCHAR2(150) NOT NULL,
    Product_description VARCHAR2(250) NOT NULL,
    Category_id         VARCHAR2(8) NOT NULL,
    Product_type_id     NUMBER(8)NOT NULL,
    Price               NUMBER(5,2) NOT NULL,
    Number_in_stock     NUMBER(30),
    Stock_id            NUMBER(8),
    Manufacturer_id      NUMBER(8),
    CONSTRAINT fk_prod_cat FOREIGN KEY ( Category_id) REFERENCES categories(Category_id),
    CONSTRAINT fk_prod_ptype FOREIGN KEY ( Product_type_id) REFERENCES product_types(Product_type_id),
    CONSTRAINT fk_prod_stock FOREIGN KEY (stock_id) REFERENCES stocks(stock_id),
    CONSTRAINT fk_prod_manuf FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id)
  );
