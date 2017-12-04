/**===============================================*\
Name...............:   Normalized table ce_types 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   28-Nov-2017
\*=============================================== */
DROP TABLE ce_types;
--**********************************************

CREATE TABLE ce_types (
    type_id     NUMBER(4) PRIMARY KEY,
    type_code   VARCHAR2(5 CHAR),
    type_name   VARCHAR2(100 CHAR),
    subcat_id   NUMBER(5),
    insert_dt   DATE,
    update_dt   DATE,
    CONSTRAINT fk_ce_subcat_id FOREIGN KEY ( subcat_id )
        REFERENCES ce_subcategories ( subcat_id )
);
--**********************************************

INSERT INTO bl_3nf.ce_types (
    type_id,
    type_code,
    type_name,
    subcat_id,
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

INSERT INTO bl_3nf.ce_types (
    type_id,
    type_code,
    type_name,
    subcat_id,
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
--select * from ce_types;