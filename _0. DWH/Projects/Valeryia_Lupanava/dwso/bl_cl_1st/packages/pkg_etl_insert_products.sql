CREATE OR REPLACE PACKAGE pkg_etl_insert_products
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_product_types;
  PROCEDURE insert_table_collections;
  PROCEDURE insert_table_lines;
  PROCEDURE insert_table_products;
  PROCEDURE insert_table_product_details;
  PROCEDURE merge_table_ce_collections;
  PROCEDURE merge_table_ce_lines;
  PROCEDURE merge_table_ce_product_types;
  PROCEDURE merge_table_ce_products;
  PROCEDURE merge_table_ce_product_details;
  
END pkg_etl_insert_products;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_products
AS
---------------------------------------------------  
PROCEDURE insert_table_product_types
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_product_types');
  INSERT INTO cls_product_types (
                                 product_type_id,
                                 product_type,
                                 start_dt,
                                 is_active
                                 )
  SELECT   cls_product_types_seq.NEXTVAL as product_type_id,
           product_type,
           SYSDATE AS start_dt,
           'TRUE' AS is_active
  FROM     (SELECT DISTINCT product_type
           FROM wrk_products);

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_product_types;
---------------------------------------------------  
PROCEDURE insert_table_collections
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_collections');
  INSERT INTO cls_collections (
                                 collection_id,
                                 collection_name,
                                 start_dt,
                                 is_active
                                 )
  SELECT   cls_collections_seq.NEXTVAL as collection_id,
           collection_name,
           SYSDATE AS start_dt,
           'TRUE' AS is_active
  FROM     (SELECT DISTINCT collection_name
            FROM wrk_products);

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_collections;
---------------------------------------------------
PROCEDURE insert_table_lines
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_lines');
  INSERT INTO cls_lines (
                                 line_id,
                                 line_name,
                                 collection_id,
                                 start_dt,
                                 is_active
                                 )
  SELECT   cls_lines_seq.NEXTVAL as line_id,
           a.line_name,
           b.collection_id,
           SYSDATE AS start_dt,
           'TRUE' AS is_active
  FROM     (SELECT DISTINCT line_name, collection_name
           FROM wrk_products) a left join cls_collections b 
                                       ON a.collection_name = b.collection_name;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_lines;
---------------------------------------------------
PROCEDURE insert_table_products
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_products');
  INSERT INTO cls_products (
                                 product_id,
                                 product_ein,
                                 product_name,
                                 line_id,
                                 product_type_id,
                                 start_dt,
                                 is_active
                                 )
  SELECT   cls_products_seq.NEXTVAL as product_id,
           a.product_id AS product_ein,
           a.product_name,
           b.line_id,
           c.product_type_id,
           SYSDATE AS start_dt,
           'TRUE' AS is_active
  FROM     wrk_products a LEFT JOIN cls_lines b 
                                 ON a.line_name = b.line_name
                          LEFT JOIN cls_product_types c 
                                 ON a.product_type = c.product_type;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_products;
---------------------------------------------------
PROCEDURE insert_table_product_details
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_product_details');
  INSERT INTO cls_product_details (
                                   product_detail_id,
                                   product_id,
                                   bra_size_id,
                                   panty_size_id,
                                   color,
                                   price,
                                   balance,
                                   insert_dt,
                                   update_dt
                                 )
  SELECT cls_product_details_seq.NEXTVAL AS product_detail_id, 
         c.product_id,
         a.bra_size_id,
         a.panty_size_id,
         a.color,
         a.price,
         a.balance,
         SYSDATE AS insert_dt,
         SYSDATE AS update_dt
  FROM   (
  SELECT product_id,
         bsg.bra_size_id AS bra_size_id,
         0 AS panty_size_id,
         color,
         to_number(price, '9999.99') AS price,
         to_number(substr(balance,1,4)) AS balance
  FROM wrk_products pr JOIN cls_bra_sizes bsg 
                         ON pr.panty_size_id = bsg.bra_size_id
  WHERE pr.product_type = 'bra'
  UNION ALL
  SELECT product_id,
         0 AS bra_size_id,
         bsg.panty_size_id AS panty_size_id,
         color,
         to_number(price, '9999.99') AS price,
         to_number(substr(balance,1,4)) AS balance
  FROM wrk_products pr JOIN cls_panty_sizes bsg 
                         ON pr.panty_size_id = bsg.panty_size_id
  WHERE pr.product_type = 'panty') a LEFT JOIN cls_products c 
                                            ON a.product_id = c.product_ein;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_product_details;
---------------------------------------------------  
---------------------------------------------------
PROCEDURE merge_table_ce_collections
IS
BEGIN

MERGE INTO bl_3nf.ce_collections t USING
    ( SELECT collection_id,
             collection_name,
             start_dt,
             end_dt,
             is_active
      FROM   cls_collections
    MINUS
      SELECT collection_srcid AS collection_id,
             collection_desc AS collection_name,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_collections
    ) c ON ( c.collection_id = t.collection_srcid )
    WHEN matched THEN
    UPDATE SET 
               t.collection_desc  = c.collection_name,
               t.start_dt  = c.start_dt,
               t.end_dt  = c.end_dt,
               t.is_active  = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        collection_id,
        collection_srcid,
        collection_desc,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_collections_seq.NEXTVAL,
        c.collection_id,
        c.collection_name,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_collections;
---------------------------------------------------
PROCEDURE merge_table_ce_lines
IS
BEGIN

MERGE INTO bl_3nf.ce_lines t USING
    ( SELECT line_id,
             line_name,
             collection_id,
             start_dt,
             end_dt,
             is_active
      FROM   cls_lines
    MINUS
      SELECT line_srcid AS line_id,
             line_desc  AS line_name,
             collection_srcid AS collection_id,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_lines
    ) c ON ( c.line_id = t.line_srcid )
    WHEN matched THEN
    UPDATE SET 
               t.line_desc  = c.line_name,
               t.collection_srcid  = c.collection_id,
               t.start_dt  = c.start_dt,
               t.end_dt  = c.end_dt,
               t.is_active  = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        line_id,
        line_srcid,
        line_desc,
        collection_srcid,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_lines_seq.NEXTVAL,
        c.line_id,
        c.line_name,
        c.collection_id,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_lines;
---------------------------------------------------
PROCEDURE merge_table_ce_product_types
IS
BEGIN
MERGE INTO bl_3nf.ce_product_types t USING
    ( SELECT product_type_id,
             product_type,
             start_dt,
             end_dt,
             is_active
      FROM   cls_product_types
    MINUS
      SELECT product_type_srcid AS product_type_id,
             product_type_desc  AS product_type,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_product_types
    ) c ON ( c.product_type_id = t.product_type_srcid )
    WHEN matched THEN
    UPDATE SET 
               t.product_type_desc  = c.product_type,
               t.start_dt  = c.start_dt,
               t.end_dt  = c.end_dt,
               t.is_active  = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        product_type_id,
        product_type_srcid,
        product_type_desc,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_product_types_seq.NEXTVAL,
        c.product_type_id,
        c.product_type,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_product_types;
---------------------------------------------------
PROCEDURE merge_table_ce_products
IS
BEGIN

MERGE INTO bl_3nf.ce_products t USING
    ( SELECT product_id,
             product_ein,
             product_name,
             line_id,
             product_type_id,
             start_dt,
             end_dt,
             is_active
      FROM   cls_products
    MINUS
      SELECT product_srcid AS product_id,
             product_ein,
             product_desc  AS product_name,
             line_srcid AS line_id,
             product_type_srcid AS product_type_id,            
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_products
    ) c ON ( c.product_id = t.product_srcid )
    WHEN matched THEN
    UPDATE SET 
               t.product_ein  = c.product_ein,
               t.product_desc  = c.product_name,
               t.line_srcid  = c.line_id,
               t.product_type_srcid  = c.product_type_id,
               t.start_dt  = c.start_dt,
               t.end_dt  = c.end_dt,
               t.is_active  = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        product_id,
        product_srcid,
        product_ein,
        product_desc,
        line_srcid,
        product_type_srcid,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_products_seq.NEXTVAL,
        c.product_id,
        c.product_ein,
        c.product_name,
        c.line_id,
        c.product_type_id,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_products;
---------------------------------------------------
PROCEDURE merge_table_ce_product_details
IS
BEGIN

MERGE INTO bl_3nf.ce_product_details t USING
    ( SELECT product_detail_id,
             product_id,
             bra_size_id,
             panty_size_id,
             color,
             price,
             balance,
             insert_dt,
             update_dt
      FROM   cls_product_details
    MINUS
      SELECT product_details_srcid AS product_detail_id,
             product_srcid  AS product_id,
             bra_size_srcid AS bra_size_id,
             panty_size_srcid AS panty_size_id,            
             color,
             price,
             product_balance AS balance,
             insert_dt,
             update_dt
      FROM   bl_3nf.ce_product_details
    ) c ON ( c.product_detail_id = t.product_details_srcid )
    WHEN matched THEN
    UPDATE SET 
              t.product_srcid  = c.product_id,
              t.bra_size_srcid  = c.bra_size_id,
              t.panty_size_srcid  = c.panty_size_id,
              t.color  = c.color,
              t.price  = c.price,
              t.product_balance  = c.balance,
              t.insert_dt  = c.insert_dt,
              t.update_dt  = c.update_dt
    WHEN NOT matched THEN
    INSERT
      (
        product_details_id,
        product_details_srcid,
        product_srcid,
        bra_size_srcid,
        panty_size_srcid,
        color,
        price,
        product_balance,
        insert_dt,
        update_dt
      )
      VALUES
      (
        bl_3nf.ce_product_details_seq.NEXTVAL,
        c.product_detail_id,
        c.product_id,
        c.bra_size_id,
        c.panty_size_id,
        c.color,
        c.price,
        c.balance,
        c.insert_dt,
        c.update_dt
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_product_details;
---------------------------------------------------
END pkg_etl_insert_products;