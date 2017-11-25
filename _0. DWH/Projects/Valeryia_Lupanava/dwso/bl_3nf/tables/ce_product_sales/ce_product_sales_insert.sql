BEGIN
FOR i IN 1..1000000
LOOP
      dbms_random.seed
      (
        i * 5
      )
      ;
INSERT INTO bl_3nf.ce_product_sales (
                                     sale_id,
                                     receipt_srcid,
                                     product_details_srcid,
                                     sale_sum_usd,
                                     sale_amount,
                                     insert_dt
                                    )
    SELECT ce_product_sales_seq.NEXTVAL AS sale_id,
           a.receipt_srcid,
           a.product_details_srcid,
           a.sale_sum,
           a.sale_amount,
           a.insert_dt
    FROM (
SELECT 
       ROUND(dbms_random.value((select min(receipt_srcid) from ce_receipts),
                         (select max(receipt_srcid) from ce_receipts))) AS receipt_srcid,
       ROUND(dbms_random.value((select min(product_details_srcid) from ce_product_details),
                         (select max(product_details_srcid) from ce_product_details))) AS product_details_srcid,
       ROUND(dbms_random.value(10000, 10000000)) AS sale_sum,
       ROUND(dbms_random.value(100, 1000)) AS sale_amount,
       sysdate as insert_dt
FROM dual
        ) a;
        
END LOOP;
END;