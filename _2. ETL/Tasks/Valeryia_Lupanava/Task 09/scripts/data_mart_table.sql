CREATE TABLE sales_by_customers
  (
    customer_surr_id NUMBER(38) ,
    age_category     VARCHAR2(200 byte) ,
    country          VARCHAR2(200 byte) ,
    receipts_amount  NUMBER(38) ,
    receipts_sum     NUMBER(38) ,
    CONSTRAINT customer_surr_id_pk PRIMARY KEY (customer_surr_id)
  );
  
INSERT INTO sales_by_customers
SELECT a.customer_surr_id
      ,age_category
      ,country
      ,COUNT(receipt_id) AS receipts_amount
      ,SUM(tot_sale_sum) AS receipts_sum 
FROM  bl_dm.dim_customers_scd a JOIN bl_dm.fct_retail_sales_dd b
  ON  a.customer_surr_id(+) = b.customer_surr_id
GROUP BY a.customer_surr_id
        ,age_category
        ,country;


