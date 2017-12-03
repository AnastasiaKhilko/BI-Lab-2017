--CE_PRODUCT_TYPES.
DROP TABLE ce_product_types;
CREATE TABLE ce_product_types
  (
    product_type_id          NUMBER(10) NOT NULL,
    product_type_srcid       VARCHAR2(50 BYTE) NOT NULL,
    product_type_name        VARCHAR2(50 BYTE) NOT NULL,
    category_srcid VARCHAR2(50 BYTE) NOT NULL,
    update_dt        DATE DEFAULT SYSDATE,
    CONSTRAINT product_type_id_pk PRIMARY KEY ( product_type_id ),
    CONSTRAINT product_type_srcid_unq UNIQUE ( product_type_srcid ),
    CONSTRAINT category_srcid_fk FOREIGN KEY ( category_srcid ) 
    REFERENCES ce_categories ( category_srcid )
  );
  