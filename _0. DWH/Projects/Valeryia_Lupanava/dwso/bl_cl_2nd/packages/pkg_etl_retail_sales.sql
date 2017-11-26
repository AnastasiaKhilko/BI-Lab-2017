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
SELECT DISTINCT
       cs.sale_id,
       cr.receipt_number AS receipt_id,
       cr.receipt_dt AS event_dt,
       cpd.product_srcid AS product_id,
       ce.employee_srcid AS employee_surr_id,
       cm.customer_srcid AS customer_surr_id,
       ct.store_srcid AS store_id,
       cr.payment_method_srcid AS payment_method_surr_id,
       cs.sale_sum_usd AS tot_sale_sum,
       cs.sale_amount AS tot_sale_amount,
       cs.insert_dt AS insert_dt,
       SYSDATE AS update_dt
FROM   bl_3nf.ce_receipts cr left join bl_3nf.ce_product_sales cs
                                    on cr.receipt_srcid = cs.receipt_srcid
                             left join bl_3nf.ce_employees ce
                                    on cr.employee_srcid = ce.employee_srcid
                             left join bl_3nf.ce_customers cm
                                    on cr.customer_srcid = cm.customer_srcid
                             left join bl_3nf.ce_stores ct
                                    on cr.store_srcid = ct.store_srcid
                             left join BL_3NF.ce_product_details cpd
                                    on cs.product_details_srcid = cpd.product_details_srcid
WHERE cs.sale_id IS NOT NULL;

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
    ) c ON ( c.sale_id = t.sale_id )
    WHEN matched THEN
    UPDATE SET t.receipt_id = c.receipt_id 
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
        tot_sale_sum,
        tot_sale_amount,
        insert_dt,
        update_dt 
      )
      VALUES
      (
        c.sale_id,
        c.receipt_id,
        c.event_dt,
        c.product_surr_id,
        c.employee_surr_id,
        c.customer_surr_id,
        c.store_id,
        c.payment_method_surr_id,
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