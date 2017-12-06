DROP TABLE ce_fct_sales;
--**********************************************

CREATE TABLE ce_fct_sales (
    sale_id     NUMBER(15),
    sale_code   VARCHAR2(30 CHAR),
    sale_date   DATE,
    product_id      NUMBER(12,0),
    customer_id      NUMBER(12,0),
    store_id       NUMBER(2,0),
    employee_id       NUMBER(2,0),
    quantity     NUMBER(3),
    price varchar2 (20 char),
    discount varchar2 (20 char),
    insert_dt    DATE
);