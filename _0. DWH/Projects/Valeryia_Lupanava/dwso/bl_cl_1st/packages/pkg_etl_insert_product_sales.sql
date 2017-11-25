CREATE OR REPLACE PACKAGE pkg_etl_insert_product_sales
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_product_sales;
						
END pkg_etl_insert_product_sales;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_product_sales
AS
---------------------------------------------------  
PROCEDURE insert_table_product_sales
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_product_sales');
  BEGIN
  
    FOR i IN 1..1000000
    LOOP
      dbms_random.seed
      (
        i * 5
      )
      ;
    INSERT INTO cls_product_sales (
                                    sale_id,
                                    receipt_id,
                                    product_detail_id,
                                    sale_sum,
                                    sale_amount
                                  )
    SELECT cls_product_sales_seq.NEXTVAL AS sale_id,
           a.receipt_id,
           a.product_detail_id,
           a.sale_sum,
           a.sale_amount
    FROM (
SELECT 
       ROUND(dbms_random.value((select min(receipt_id) from cls_receipts), 
                         (select max(receipt_id) from cls_receipts))) AS receipt_id,
       ROUND(dbms_random.value((select min(product_detail_id) from cls_product_details),
                         (select max(product_detail_id) from cls_product_details))) AS product_detail_id,
       ROUND(dbms_random.value(10000, 10000000)) AS sale_sum,
       ROUND(dbms_random.value(100, 1000)) AS sale_amount
FROM dual
        ) a;
  
    END LOOP;
  
  END;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_product_sales;
--------------------------------------------------- 
END pkg_etl_insert_product_sales;