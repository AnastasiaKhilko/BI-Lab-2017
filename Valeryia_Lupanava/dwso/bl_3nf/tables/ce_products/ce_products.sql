CREATE TABLE products (
    product_id            NUMBER(10) NOT NULL,
    product_name          VARCHAR2(10 BYTE),
    product_description   VARCHAR2(40 BYTE),
    line_id               NUMBER(10),
    product_type_id       NUMBER(10) NOT NULL,
    CONSTRAINT product_id_pk PRIMARY KEY ( product_id ),
    CONSTRAINT line_id_fk FOREIGN KEY ( line_id )
        REFERENCES lines ( line_id ),
    CONSTRAINT product_type_id_fk FOREIGN KEY ( product_type_id )
        REFERENCES product_types ( product_type_id )
);
