CREATE OR REPLACE PACKAGE pkg_etl_insert_products
AUTHID CURRENT_USER
AS
  PROCEDURE insert_cls_products;						
END pkg_etl_insert_products;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_products
AS
PROCEDURE insert_cls_products
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_products');
  INSERT INTO cls_products
          SELECT DISTINCT
                 pi.product_info_id AS product_surr_id,
                 pi.product_info_srcid AS product_id,
                 pr.product_name AS product_name,                 
                 cat.category_name AS category_name, 
                 pt.product_type_name AS product_type,
                 price,
                 pr.start_dt,
                 pr.end_dt,
                 pr.is_active
          FROM   bl_3nf.ce_product_info pi left join bl_3nf.ce_products pr
                                                     on pi.product_srcid = pr.product_srcid                                            
                                              left join bl_3nf.ce_product_types pt
                                                     on pr.product_type_srcid = pt.product_type_srcid
                                              left join bl_3nf.ce_categories cat
                                                     on pt.category_srcid = cat.category_srcid
                                              left join bl_3nf.ce_product_types pt
                                                     on pr.product_type_srcid = pt.product_type_srcid;
        COMMIT;
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
END insert_cls_products; 
END pkg_etl_insert_products;
/