-- CLS_PRODUCT_DETAILS.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_product_details', object_type => 'table');
END;

CREATE TABLE cls_product_details
  (
    product_detail_id NUMBER ( 10 ) NOT NULL,
    product_id        NUMBER ( 10 ) NOT NULL,
    bra_size_id       NUMBER ( 10 ) DEFAULT 0,
    panty_size_id     NUMBER ( 10 ) DEFAULT 0,
    color             VARCHAR2 ( 200 CHAR ) NOT NULL,
    price             NUMBER ( 10,2 ) NOT NULL,
    balance           NUMBER ( 10,2 ) NOT NULL,
    insert_dt         DATE DEFAULT '01-JAN-1990' ,
    update_dt         DATE DEFAULT '31-DEC-9999'
  );