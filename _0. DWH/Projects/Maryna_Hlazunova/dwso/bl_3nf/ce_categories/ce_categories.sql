/**===============================================*\
Name...............:   Normalized table ce_categories 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   27-Nov-2017
\*=============================================== */
DROP TABLE ce_categories;
--**********************************************

CREATE TABLE ce_categories (
    cat_id      NUMBER(2) PRIMARY KEY,
    cat_code    VARCHAR2(3 CHAR),
    category    VARCHAR2(100 CHAR),
    insert_dt   DATE,
    update_dt   DATE
);
--**********************************************

INSERT INTO bl_3nf.ce_categories (
    cat_id,
    cat_code,
    category,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_categories (
    cat_id,
    cat_code,
    category,
    insert_dt,
    update_dt
) VALUES (
    -99,
    'N/A',
    'N/A',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

COMMIT;
--**********************************************

-- SELECT  *  FROM    ce_categories;