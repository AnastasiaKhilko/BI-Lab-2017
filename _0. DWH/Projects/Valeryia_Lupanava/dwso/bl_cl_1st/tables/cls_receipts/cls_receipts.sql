-- CLS_RECEIPTS.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_receipts', object_type => 'table');
END;

CREATE TABLE cls_receipts
  (
    receipt_id        NUMBER ( 38 ) NOT NULL,
    receipt_number    NUMBER ( 38 ) NOT NULL,
    receipt_dt        DATE NOT NULL,
    store_id          NUMBER ( 38 ) NOT NULL,
    employee_id       NUMBER ( 38 ) NOT NULL,
    customer_id       NUMBER ( 38 ) NOT NULL,
    payment_method_id NUMBER ( 38 ) NOT NULL,
    product_detail_id NUMBER ( 38 ) NOT NULL,
    receipt_sum       NUMBER ( 38 ) NOT NULL,
    insert_dt         DATE DEFAULT '31-DEC-1999'
  );