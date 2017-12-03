-- CLS_PRODUCT_INFO.
DROP TABLE cls_product_info;
CREATE TABLE cls_product_info
  (
    product_info_id VARCHAR2 ( 200 CHAR ) NOT NULL,
    product_id        VARCHAR2 ( 200 CHAR ),
    price             VARCHAR2 ( 200 CHAR ),
    raiting           VARCHAR2 ( 200 CHAR ),
    balance           VARCHAR2 ( 200 CHAR ),
    insert_dt         DATE DEFAULT '01-JAN-1990' ,
    update_dt         DATE DEFAULT '31-DEC-9999'
  );