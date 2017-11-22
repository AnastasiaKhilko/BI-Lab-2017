BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_promotions', Object_Type => 'table');
END;

CREATE TABLE ce_promotions (
    promotion_srcid        NUMBER(10) NOT NULL,
    promotion_type_srcid   NUMBER(10) NOT NULL,
    collection_srcid       NUMBER(10) DEFAULT '-99',
    line_srcid             NUMBER(10) DEFAULT '-99',
    product_type_srcid     NUMBER(10) DEFAULT '-99',
    start_dt               DATE NOT NULL,
    end_dt                 DATE NOT NULL,
    is_active              VARCHAR2(4) NOT NULL,
    CONSTRAINT promotion_srcid_pk PRIMARY KEY ( promotion_srcid ),
    CONSTRAINT collection_pr_srcid_fk FOREIGN KEY ( collection_srcid )
        REFERENCES ce_collections ( collection_srcid ),
    CONSTRAINT line_pr_srcid_fk FOREIGN KEY ( line_srcid )
        REFERENCES ce_lines ( line_srcid ),
    CONSTRAINT product_type_pr_srcid_fk FOREIGN KEY ( product_type_srcid )
        REFERENCES ce_product_types ( product_type_srcid ),
    CONSTRAINT promotion_type_srcid_fk FOREIGN KEY ( promotion_type_srcid )
        REFERENCES ce_promotion_types ( promotion_type_srcid )
);