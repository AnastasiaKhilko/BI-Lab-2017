CREATE TABLE fact_retail_sales (
    sale_id              NUMBER(10) NOT NULL,
    receipt_id           NUMBER(10) NOT NULL,
    date_id              NUMBER(10) NOT NULL,
    product_details_id   NUMBER(10) NOT NULL,
    employee_id          NUMBER(10) NOT NULL,
    customer_id          NUMBER(10),
    store_id             NUMBER(10) NOT NULL,
    payment_method_id    NUMBER(10) NOT NULL,
    promotion_id         NUMBER(10),
    currency_id          NUMBER(10) NOT NULL,
    sale_sum             NUMBER(10) NOT NULL,
    sale_amount          NUMBER(10) NOT NULL
)
PARTITION BY RANGE (date_id) INTERVAL (NUMTOYMINTERVAL(1,'MONTH'))
SUBPARTITION BY LIST (store_id) SUBPARTITION TEMPLATE
( SUBPARTITION local VALUES('...'),
  SUBPARTITION Russia VALUES ('...'),
  SUBPARTITION Europe VALUES ('...'),
  SUBPARTITION Asia VALUES ('I')
)
 (PARTITION half_year_2017 VALUES LESS THAN (TO_DATE('01-JUL-2017','dd-MON-yyyy'))
  )
PARALLEL;


