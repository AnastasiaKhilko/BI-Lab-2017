BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_products', Object_Type => 'table');
END;

CREATE TABLE ce_products (
    product_srcid         NUMBER(10) NOT NULL,
    product_name          VARCHAR2(10 BYTE) NOT NULL,
    product_description   VARCHAR2(40 BYTE) NOT NULL,
    line_srcid            NUMBER(10) NOT NULL,
    product_type_srcid    NUMBER(10) NOT NULL,
    start_dt              DATE NOT NULL,
    end_dt                DATE NOT NULL,
    is_active             VARCHAR2(4) NOT NULL,
    CONSTRAINT product_srcid_pk PRIMARY KEY ( product_srcid ),
    CONSTRAINT line_srcid_fk FOREIGN KEY ( line_srcid )
        REFERENCES ce_lines ( line_srcid ),
    CONSTRAINT product_type_srcid_fk FOREIGN KEY ( product_type_srcid )
        REFERENCES ce_product_types ( product_type_srcid )
);