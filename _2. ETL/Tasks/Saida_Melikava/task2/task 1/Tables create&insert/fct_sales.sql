DROP TABLE fct_sales;
CREATE TABLE fct_sales
  (
    event_dt    DATE NOT NULL,
    product_id  NUMBER(8,2) NOT NULL,
    employee_id NUMBER(8,2) NOT NULL,
    store_id    NUMBER(8,2) NOT NULL,
    check_id    NUMBER(15,2) NOT NULL,
    quantity    NUMBER(8,2) NOT NULL,
    price       NUMBER(10,3) NOT NULL,
    discount    NUMBER(4,3)
  );
INSERT
INTO fct_sales
  (
    EVENT_DT,
    product_id,
    employee_id,
    store_id,
    check_id,
    quantity ,
    price,
    discount
  )
SELECT event_dt,
  product_id,
  employee_id,
  store_id,
  check_id,
  quantity ,
  price,
  discount
FROM
  (SELECT TO_DATE( TRUNC( DBMS_RANDOM.value( TO_CHAR(DATE '2000-01-01','J') ,TO_CHAR(SYSDATE,'J') ) ),'J') AS event_dt,
    ROUND(dbms_random.value(
    (SELECT MIN(product_id) FROM products
    ),
    (SELECT MAX(product_id) FROM products
    ))) AS product_id,
    ROUND(dbms_random.value(
    (SELECT MIN(employee_id) FROM employees
    ),
    (SELECT MAX(employee_id) FROM employees
    ))) AS employee_id,
    ROUND(dbms_random.value(
    (SELECT MIN(store_id) FROM stores
    ),
    (SELECT MAX(store_id) FROM stores
    )))                                        AS store_id,
    ROUND(dbms_random.value(1,1000000))        AS check_id,
    ROUND(dbms_random.value(1,10))             AS quantity,
    ABS(ROUND((DBMS_RANDOM.NORMAL()*10000),2)) AS price,
    ROUND((dbms_random.value(0,1)),3)          AS discount
  FROM
    ( SELECT level n FROM dual CONNECT BY level <= 20000
    )
  );
COMMIT;
SELECT * FROM fct_sales;
SELECT COUNT(*) as COUNT FROM fct_sales;
