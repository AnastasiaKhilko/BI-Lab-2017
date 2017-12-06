DROP TABLE cls_fct_sales;
--**********************************************

CREATE TABLE cls_fct_sales (
    sale_code varchar2(30),
    sale_date date,
    product_id  NUMBER(12,0),
    customer_id NUMBER(12,0),
    store_id    NUMBER(12,0),
    employee_id NUMBER(12,0),
    quantity number(4),
    price varchar(20 char),
    discount varchar2(20 char)
  );
