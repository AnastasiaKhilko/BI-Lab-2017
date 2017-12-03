/**===============================================*\
Name...............:   Table ce_products BL_3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   29-Nov-2017
\*=============================================== */
DROP TABLE ce_products;
--**********************************************

CREATE TABLE ce_products (
    prod_id        NUMBER(10) PRIMARY KEY,
    prod_code      VARCHAR2(8 CHAR),
    vendor_code    VARCHAR2(8 CHAR),
    product_name   VARCHAR2(100 CHAR),
    color_id       NUMBER(3),
    brand_id       NUMBER(6),
    type_id        NUMBER(4),
    start_dt       DATE,
    end_dt         DATE,
    is_active      VARCHAR2(1 CHAR),
    CONSTRAINT fk_pr_color_id FOREIGN KEY ( color_id )
        REFERENCES ce_colors ( color_id ),
    CONSTRAINT fk_pr_brand_id FOREIGN KEY ( brand_id )
        REFERENCES ce_brands ( brand_id ),
    CONSTRAINT fk_pr_type_id FOREIGN KEY ( type_id )
        REFERENCES ce_types ( type_id )
);
--*********************************************

INSERT INTO bl_3nf.ce_products (
    prod_id,
    prod_code,
    vendor_code,
    product_name,
    color_id,
    brand_id,
    type_id,
    start_dt,
    end_dt,
    is_active
) VALUES (
    -98,
    'N/D',
    'N/D',
    'N/D',
    -98,
    -98,
    -98,
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    'Y'
);

INSERT INTO bl_3nf.ce_products (
    prod_id,
    prod_code,
    vendor_code,
    product_name,
    color_id,
    brand_id,
    type_id,
    start_dt,
    end_dt,
    is_active
) VALUES (
    -99,
    'N/D',
    'N/D',
    'N/D',
    -99,
    -99,
    -99,
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    'Y'
);

COMMIT;
--*********************************************
-- select * from ce_products;