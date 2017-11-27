CREATE OR REPLACE PACKAGE pkg_etl_insert_products
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_products;
  PROCEDURE merge_table_products;
						
END pkg_etl_insert_products;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_products
AS
---------------------------------------------------  
PROCEDURE insert_table_products
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_products_scd');
  INSERT INTO cls_products_scd
SELECT DISTINCT
       cc.product_srcid AS product_surr_id,
       cs.product_ein AS product_id,
       cs.product_desc AS product_desc,
       cl.line_desc AS line_name,
       ccl.collection_desc AS collection_name,
       pt.product_type_desc AS product_type,
       bra_size_uk,
       bra_size_usa,
       bra_size_eu,
       bra_size_fr,
       bra_size_uie,
       panty_size_uk,
       panty_size_usa,
       panty_size_eu,
       panty_size_fr,
       panty_size_uie,
       color,
       price,
       cs.start_dt,
       cs.end_dt,
       cs.is_active
FROM   bl_3nf.ce_product_details cc left join bl_3nf.ce_products cs
                                           on cc.product_srcid = cs.product_srcid
                                    left join bl_3nf.ce_bra_size_grid cn
                                           on cc.bra_size_srcid = cn.bra_size_srcid
                                    left join bl_3nf.ce_panty_size_grid cr
                                           on cc.panty_size_srcid = cr.panty_size_srcid
                                    left join bl_3nf.ce_lines cl
                                           on cs.line_srcid = cl.line_srcid
                                    left join bl_3nf.ce_collections ccl
                                           on cl.collection_srcid = ccl.collection_srcid
                                    left join bl_3nf.ce_product_types pt
                                           on cs.product_type_srcid = pt.product_type_srcid;
  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_products;
---------------------------------------------------  
PROCEDURE merge_table_products
IS
BEGIN
MERGE INTO bl_dm.dim_products_scd t USING
    ( SELECT *
      FROM   cls_products_scd
    MINUS
      SELECT *          
      FROM   bl_dm.dim_products_scd
    ) c ON ( c.product_surr_id = t.product_surr_id )
    WHEN matched THEN
    UPDATE SET t.product_id = c.product_id,
               t.product_desc = c.product_desc,
               t.line_name = c.line_name,
               t.collection_name = c.collection_name,
               t.product_type = c.product_type,
               t.bra_size_uk = c.bra_size_uk,
               t.bra_size_usa = c.bra_size_usa,
               t.bra_size_eu = c.bra_size_eu,
               t.bra_size_fr = c.bra_size_fr,
               t.bra_size_uie = c.bra_size_uie,
               t.panties_size_uk = c.panties_size_uk,
               t.panties_size_usa = c.panties_size_usa,
               t.panties_size_eu = c.panties_size_eu,
               t.panties_size_fr = c.panties_size_fr,
               t.panties_size_uie = c.panties_size_uie,
               t.color = c.color,
               t.price = c.price,
               t.start_dt = c.start_dt,
               t.end_dt = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        product_surr_id,
        product_id,
        product_desc,
        line_name,
        collection_name,
        product_type,
        bra_size_uk,
        bra_size_usa,
        bra_size_eu,
        bra_size_fr,
        bra_size_uie,
        panties_size_uk,
        panties_size_usa,
        panties_size_eu,
        panties_size_fr,
        panties_size_uie,
        color,
        price,
        start_dt,
        end_dt,
        is_active 
      )
      VALUES
      (
        c.product_surr_id,
        c.product_id,
        c.product_desc,
        c.line_name,
        c.collection_name,
        c.product_type,
        c.bra_size_uk,
        c.bra_size_usa,
        c.bra_size_eu,
        c.bra_size_fr,
        c.bra_size_uie,
        c.panties_size_uk,
        c.panties_size_usa,
        c.panties_size_eu,
        c.panties_size_fr,
        c.panties_size_uie,
        c.color,
        c.price,
        c.start_dt,
        c.end_dt,
        c.is_active 
      ) ;
    COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END merge_table_products;
--------------------------------------------------- 
END pkg_etl_insert_products;