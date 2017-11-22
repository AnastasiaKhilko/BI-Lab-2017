CREATE OR REPLACE PACKAGE pkg_etl_insert_products
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_product_types;
  PROCEDURE insert_table_collections;
  PROCEDURE insert_table_lines;
  PROCEDURE insert_table_products;
						
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
                                 product_type
                                 )
  SELECT   cls_product_types_seq.NEXTVAL as product_type_id,
           product_type
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
                                 collection_name
                                 )
  SELECT   cls_collections_seq.NEXTVAL as collection_id,
           collection_name
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
                                 collection_id
                                 )
  SELECT   cls_lines_seq.NEXTVAL as line_id,
           a.line_name,
           b.collection_id
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
                                 product_name,
                                 line_id,
                                 product_type_id
                                 )
  SELECT   cls_products_seq.NEXTVAL as product_id,
           a.product_name,
           b.line_id,
           c.product_type_id
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
END pkg_etl_insert_products;