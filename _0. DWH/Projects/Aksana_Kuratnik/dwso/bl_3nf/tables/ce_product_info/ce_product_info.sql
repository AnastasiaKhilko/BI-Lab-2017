--CE_PRODUCT_INFO.
DROP TABLE ce_product_info;
CREATE TABLE ce_product_info
  (
    product_info_id    NUMBER(10) NOT NULL,
    product_info_srcid VARCHAR2 ( 200 CHAR ) NOT NULL,
    product_srcid      VARCHAR2 ( 200 CHAR ) NOT NULL,
    price              NUMBER(10,2) NOT NULL,
    raiting            VARCHAR2 ( 200 CHAR ),
    balance            NUMBER(10) NOT NULL,
    insert_dt          DATE DEFAULT '01-JAN-1990',
    update_dt          DATE DEFAULT '31-DEC-9999',
    CONSTRAINT product_info_id_pk PRIMARY KEY ( product_info_id ),
    CONSTRAINT product_info_srcid_unq UNIQUE ( product_info_srcid ),
    CONSTRAINT product_srcid_fk FOREIGN KEY ( product_srcid ) REFERENCES ce_products ( product_srcid )
  );