-- CLS_PRODUCT_SALES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_product_sales', object_type => 'table');
END;

CREATE TABLE cls_product_sales
  (
    sale_id           NUMBER ( 38 ) NOT NULL,
    receipt_id        NUMBER ( 38 ) NOT NULL,
    product_detail_id NUMBER ( 38 ) NOT NULL,
    sale_sum          NUMBER ( 38,2 ) NOT NULL,
    sale_amount       NUMBER ( 38,2 ) NOT NULL,
    insert_dt         DATE DEFAULT SYSDATE
  );