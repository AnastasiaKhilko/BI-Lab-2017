--CE_DELIVERY_METHODS.
DROP TABLE ce_delivery_methods;
CREATE TABLE ce_delivery_methods
  (
    delivery_method_id    NUMBER(38) NOT NULL,
    delivery_method_srcid VARCHAR2(200 BYTE) NOT NULL,
    delivery_method_desc  VARCHAR2(200 BYTE) NOT NULL,
    start_dt             DATE DEFAULT '01-JAN-1990',
    end_dt               DATE DEFAULT '31-DEC-9999',
    is_active            VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT delivery_method_id_pk PRIMARY KEY ( delivery_method_id ),
    CONSTRAINT delivery_method_srcid_unq UNIQUE ( delivery_method_srcid )
  );