create table dim_products
  (
    Product_id          VARCHAR2(25) PRIMARY KEY,
    Product_name        VARCHAR2(150) NOT NULL,
    Product_description VARCHAR2(250) NOT NULL,
    product_Category    VARCHAR2(30) NOT NULL,
    product_type      VARCHAR2(10 BYTE),
    Price               NUMBER(5,2) NOT NULL,
    Manufacturer_name    varchar2(30),
    Number_in_stock     NUMBER(30)

);
