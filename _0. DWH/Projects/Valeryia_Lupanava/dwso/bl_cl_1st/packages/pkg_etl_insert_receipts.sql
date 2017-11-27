CREATE OR REPLACE PACKAGE pkg_etl_insert_receipts
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_receipts;
  PROCEDURE merge_table_ce_receipts;
					
END pkg_etl_insert_receipts;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_receipts
AS
---------------------------------------------------  
PROCEDURE insert_table_receipts
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_receipts');
  BEGIN
  
    FOR i IN 1..100000
    LOOP
      dbms_random.seed
      (
        i * 5
      )
      ;
    INSERT INTO cls_receipts (
                                receipt_id,
                                receipt_number,
                                receipt_dt,
                                store_id,
                                employee_id,
                                customer_id,
                                payment_method_id,
                                product_detail_id,
                                receipt_sum,
                                insert_dt
                              )
    SELECT cls_receipts_seq.NEXTVAL AS receipt_id,
           receipt_number,
           receipt_dt,
           store_id,
           employee_id,
           customer_id,
           payment_method_id,
           product_detail_id,
           receipt_sum,
           receipt_dt AS insert_dt
    FROM (
        SELECT TRUNC(dbms_random.value(100000000000, 9999999999999)) AS receipt_number ,
               TRUNC ( (sysdate + 4) + dbms_random.value ( 1, 1000 ) )    AS receipt_dt ,
               ROUND ( dbms_random.value ( ( SELECT MIN ( store_id ) FROM cls_stores), ( SELECT MAX ( store_id ) FROM cls_stores) ) ) AS store_id ,
               ROUND ( dbms_random.value ( ( SELECT MIN ( employee_id) FROM cls_employees),(SELECT MAX (employee_id) FROM cls_employees))) AS employee_id,
               ROUND ( dbms_random.value ( ( SELECT MIN ( customer_id ) FROM cls_customers), ( SELECT MAX ( customer_id ) FROM cls_customers) ) ) AS customer_id,
               ROUND ( dbms_random.value ( ( SELECT MIN ( payment_method_id ) FROM cls_payment_methods), ( SELECT MAX ( payment_method_id ) FROM cls_payment_methods) ) ) AS payment_method_id,
               ROUND ( dbms_random.value ( ( SELECT MIN ( product_detail_id ) FROM cls_product_details), ( SELECT MAX ( product_detail_id ) FROM cls_product_details) ) ) AS product_detail_id,
               ROUND ( dbms_random.value( 100, 99999), 2) AS receipt_sum 
         FROM dual
        );
  
    END LOOP;
  
  END;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_receipts;
--------------------------------------------------- 
---------------------------------------------------
PROCEDURE merge_table_ce_receipts
IS
BEGIN

MERGE INTO bl_3nf.ce_receipts t USING
    ( SELECT receipt_id,
             receipt_number,
             receipt_dt,
             store_id,
             employee_id,
             customer_id,
             payment_method_id,
             product_detail_id,
             receipt_sum,
             insert_dt
      FROM   cls_receipts
    MINUS
      SELECT receipt_srcid AS receipt_id,
             receipt_number,
             receipt_dt,
             store_srcid AS store_id,
             employee_srcid AS employee_id,
             customer_srcid AS customer_id,
             payment_method_srcid AS payment_method_id,
             product_detail_srcid AS product_detail_id,
             receipt_sum_usd AS receipt_sum,
             insert_dt 
      FROM   bl_3nf.ce_receipts
    ) c ON ( c.receipt_id = t.receipt_srcid )
    WHEN matched THEN
    UPDATE SET 
              t.receipt_number  = c.receipt_number,
              t.receipt_dt  = c.receipt_dt,
              t.store_srcid  = c.store_id,
              t.employee_srcid  = c.employee_id,
              t.customer_srcid  = c.customer_id,
              t.payment_method_srcid  = c.payment_method_id,
              t.product_detail_srcid  = c.product_detail_id,
              t.receipt_sum_usd  = c.receipt_sum,
              t.insert_dt  = c.insert_dt
    WHEN NOT matched THEN
    INSERT
      (
        receipt_id,
        receipt_srcid,
        receipt_number,
        receipt_dt,
        store_srcid,
        employee_srcid,
        customer_srcid,
        payment_method_srcid,
        product_detail_srcid,
        receipt_sum_usd,
        insert_dt 
      )
      VALUES
      (
        bl_3nf.ce_receipts_seq.NEXTVAL,
        c.receipt_id,
        c.receipt_number,
        c.receipt_dt,
        c.store_id,
        c.employee_id,
        c.customer_id,
        c.payment_method_id,
        c.product_detail_id,
        c.receipt_sum,
        c.insert_dt
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_receipts;
---------------------------------------------------
END pkg_etl_insert_receipts;