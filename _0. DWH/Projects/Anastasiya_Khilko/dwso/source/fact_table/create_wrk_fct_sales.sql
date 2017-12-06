DROP TABLE wrk_fct_sales;
CREATE TABLE wrk_fct_sales
  (
    sale_code NUMBER(15),
    DAY       NUMBER(2,0),
    MONTH     NUMBER(2,0),
    YEAR      NUMBER(4,0),
    product_id  NUMBER(12,0),
    customer_id NUMBER(12,0),
    store_id    NUMBER(12,0),
    employee_id NUMBER(12,0),
    quantity number(4)
  );