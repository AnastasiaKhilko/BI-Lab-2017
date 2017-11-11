CREATE TABLE promotions (
    promotion_id        NUMBER(10) NOT NULL,
    promotion_type_id   NUMBER(10) NOT NULL,
    start_date          DATE NOT NULL,
    end_date            DATE,
    collection_id       NUMBER(10),
    line_id             NUMBER(10),
    product_type_id     NUMBER(10),
    CONSTRAINT promotion_id_pk PRIMARY KEY ( promotion_id ),
    CONSTRAINT collection_pr_id_fk FOREIGN KEY ( collection_id )
        REFERENCES collections ( collection_id ),
    CONSTRAINT line_pr_id_fk FOREIGN KEY ( line_id )
        REFERENCES lines ( line_id ),
    CONSTRAINT product_type_pr_id_fk FOREIGN KEY ( product_type_id )
        REFERENCES product_types ( product_type_id ),
    CONSTRAINT promotion_type_id_fk FOREIGN KEY ( promotion_type_id )
        REFERENCES promotion_types ( promotion_type_id )
);