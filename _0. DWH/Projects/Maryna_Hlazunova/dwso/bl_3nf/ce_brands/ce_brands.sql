/**===============================================*\
Name...............:   Normalized table ce_brands 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE ce_brands;
--**********************************************

CREATE TABLE ce_brands (
    brand_id     NUMBER(6) PRIMARY KEY,
    nat_code     VARCHAR2(6 CHAR),
    brand_desc   VARCHAR2(100 CHAR),
    insert_dt    DATE,
    update_dt    DATE
);
--**********************************************

INSERT INTO bl_3nf.ce_brands (
    brand_id,
    nat_code,
    brand_desc,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_brands (
    brand_id,
    nat_code,
    brand_desc,
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

-- SELECT  *  FROM    ce_brands;