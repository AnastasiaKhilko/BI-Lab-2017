CREATE TABLE delivery_methods (
    delivery_method_id     NUMBER(10) NOT NULL,
    delivery_method_name   VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT delivery_method_id_pk PRIMARY KEY ( delivery_method_id )
);
