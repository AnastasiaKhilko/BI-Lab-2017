CREATE OR REPLACE PACKAGE pkg_etl_insert_retail_sales
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_retail_sales;
  PROCEDURE merge_table_retail_sales;
  
END pkg_etl_insert_retail_sales;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_retail_sales
AS
---------------------------------------------------  
PROCEDURE insert_table_retail_sales
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_fct_retail_sales_dd');
INSERT INTO cls_fct_retail_sales_dd
SELECT 
       cls_fct_retail_sales_dd_seq.NEXTVAL AS sale_id,
       cr.receipt_number AS receipt_id,
       cr.receipt_dt AS event_dt,
       cpd.product_srcid AS product_id,
       ce.employee_srcid AS employee_surr_id,
       cm.customer_srcid AS customer_surr_id,
       ct.store_srcid AS store_id,
       cr.payment_method_srcid AS payment_method_surr_id,
       cr.product_detail_srcid AS product_detail_surr_id,
       cr.receipt_sum_usd AS tot_sale_sum,
       ROUND ( dbms_random.value( 100, 99999), 2) AS tot_sale_amount,
       cr.insert_dt AS insert_dt,
       SYSDATE AS update_dt
FROM   bl_3nf.ce_receipts cr left join bl_3nf.ce_employees ce
                                    on cr.employee_srcid = ce.employee_srcid
                             left join bl_3nf.ce_customers cm
                                    on cr.customer_srcid = cm.customer_srcid
                             left join bl_3nf.ce_stores ct
                                    on cr.store_srcid = ct.store_srcid
                             left join BL_3NF.ce_product_details cpd
                                    on cr.product_detail_srcid = cpd.product_details_srcid;

COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_retail_sales;
---------------------------------------------------  
PROCEDURE merge_table_retail_sales
IS
BEGIN

MERGE INTO bl_dm.fct_retail_sales_dd t USING
    ( SELECT *
      FROM   cls_fct_retail_sales_dd
    MINUS
      SELECT *          
      FROM   bl_dm.fct_retail_sales_dd
    ) c ON ( t.receipt_id = c.receipt_id )
    WHEN matched THEN
    UPDATE SET 
               t.event_dt = c.event_dt,
               t.product_surr_id = c.product_surr_id,
               t.employee_surr_id = c.employee_surr_id,
               t.customer_surr_id = c.customer_surr_id,
               t.store_surr_id = c.store_id,
               t.payment_method_surr_id = c.payment_method_surr_id,
               t.product_detail_surr_id = c.product_detail_surr_id,
               t.tot_sale_sum = c.tot_sale_sum,
               t.tot_sale_amount = c.tot_sale_amount,
               t.insert_dt = c.insert_dt,
               t.update_dt = c.update_dt
    WHEN NOT matched THEN
    INSERT
      (
        sale_id,
        receipt_id,
        event_dt,
        product_surr_id,
        employee_surr_id,
        customer_surr_id,
        store_surr_id,
        payment_method_surr_id,
        product_detail_surr_id,
        tot_sale_sum,
        tot_sale_amount,
        insert_dt,
        update_dt 
      )
      VALUES
      (
        cls_fct_retail_sales_dd_seq.NEXTVAL,
        c.receipt_id,
        c.event_dt,
        c.product_surr_id,
        c.employee_surr_id,
        c.customer_surr_id,
        c.store_id,
        c.payment_method_surr_id,
        c.product_detail_surr_id,
        c.tot_sale_sum,
        c.tot_sale_amount,
        c.insert_dt,
        c.update_dt 
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_retail_sales;
---------------------------------------------------
END pkg_etl_insert_retail_sales;