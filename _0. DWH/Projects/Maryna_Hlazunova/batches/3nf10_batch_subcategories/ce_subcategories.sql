/**===============================================*\
Name...............:   Normalized table ce_subcategories 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   28-Nov-2017
\*=============================================== */
DROP TABLE ce_subcategories;
--**********************************************

CREATE TABLE ce_subcategories (
    subcat_id     NUMBER(5) PRIMARY KEY,
    subcat_code   VARCHAR2(5 CHAR),
    subcategory   VARCHAR2(100 CHAR),
    cat_id        NUMBER(2),
    insert_dt     DATE,
    update_dt     DATE,
    CONSTRAINT fk_cat_id FOREIGN KEY ( cat_id )
        REFERENCES ce_categories ( cat_id )
);
--**********************************************

INSERT INTO bl_3nf.ce_subcategories (
    subcat_id,
    subcat_code,
    subcategory,
    cat_id,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    'N/D',
    -98,
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_subcategories (
    subcat_id,
    subcat_code,
    subcategory,
    cat_id,
    insert_dt,
    update_dt
) VALUES (
    -99,
    'N/A',
    'N/A',
    -99,
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

COMMIT;
--**********************************************
--select * from ce_subcategories;