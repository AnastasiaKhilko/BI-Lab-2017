--CE_PRODUCTS
DROP TABLE ce_products;
CREATE TABLE ce_products
  (
    product_id         NUMBER(10) NOT NULL,
    product_srcid      VARCHAR2 ( 200 CHAR ) NOT NULL,
    product_name       VARCHAR2(60 BYTE) NOT NULL,
    product_type_srcid VARCHAR2 ( 200 CHAR ) NOT NULL,
    manufacturer_srcid VARCHAR2 ( 100 BYTE),
    start_dt           DATE DEFAULT '01-JAN-1990',
    end_dt             DATE DEFAULT '31-DEC-9999',
    is_active          VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT product_id_pk PRIMARY KEY ( product_id ),
    CONSTRAINT product_srcid_unq UNIQUE ( product_srcid ),
    CONSTRAINT product_type_srcid_fk FOREIGN KEY ( product_type_srcid ) 
    REFERENCES ce_product_types ( product_type_srcid ),
    CONSTRAINT product_manuf_srcid_fk FOREIGN KEY ( manufacturer_srcid ) 
    REFERENCES ce_manufacturers ( manufacturer_srcid )
  );