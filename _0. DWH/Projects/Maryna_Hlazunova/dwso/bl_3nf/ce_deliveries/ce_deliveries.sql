/**===============================================*\
Name...............:   Normalized table ce_deliveries 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE ce_deliveries;
--**********************************************

CREATE TABLE ce_deliveries (
    del_id      NUMBER(2) PRIMARY KEY,
    nat_code    VARCHAR2(3 CHAR),
    delivery    VARCHAR2(100 CHAR),
    insert_dt   DATE,
    update_dt   DATE
);
--**********************************************

INSERT INTO bl_3nf.ce_deliveries (
    del_id,
    nat_code,
    delivery,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_deliveries (
    del_id,
    nat_code,
    delivery,
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

-- SELECT  *  FROM    ce_deliveries;