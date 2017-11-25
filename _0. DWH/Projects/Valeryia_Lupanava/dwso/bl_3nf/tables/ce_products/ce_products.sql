BEGIN
  pkg_drop.drop_proc(object_name => 'ce_products', object_type => 'table');
END;

CREATE TABLE ce_products
  (
    product_id         NUMBER(10) NOT NULL,
    product_srcid      NUMBER(10) NOT NULL,
    product_ein        VARCHAR2 ( 200 CHAR ) NOT NULL,
    product_desc       VARCHAR2(60 BYTE) NOT NULL,
    line_srcid         NUMBER(10) NOT NULL,
    product_type_srcid NUMBER(10) NOT NULL,
    start_dt           DATE DEFAULT '01-JAN-1990',
    end_dt             DATE DEFAULT '31-DEC-9999',
    is_active          VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT product_id_pk PRIMARY KEY ( product_id ),
    CONSTRAINT product_srcid_unq UNIQUE ( product_srcid ),
    CONSTRAINT line_srcid_fk FOREIGN KEY ( line_srcid ) 
    REFERENCES ce_lines ( line_srcid ),
    CONSTRAINT product_type_srcid_fk FOREIGN KEY ( product_type_srcid ) 
    REFERENCES ce_product_types ( product_type_srcid )
  );