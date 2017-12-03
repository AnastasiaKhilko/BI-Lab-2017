/**===============================================*\
Name...............:   Normalized table ce_districts 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   24-Nov-2017
\*=============================================== */
DROP TABLE ce_districts;
--**********************************************

CREATE TABLE ce_districts (
    dis_id      NUMBER(3) PRIMARY KEY,
    dis_code    VARCHAR2(4 CHAR),
    district    VARCHAR2(100 CHAR),
    reg_id      NUMBER(2),
    insert_dt   DATE,
    update_dt   DATE,
    CONSTRAINT fk_reg_id FOREIGN KEY ( reg_id )
        REFERENCES ce_regions ( reg_id )
);
--**********************************************

INSERT INTO bl_3nf.ce_districts (
    dis_id,
    dis_code,
    district,
    reg_id,
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

INSERT INTO bl_3nf.ce_districts (
    dis_id,
    dis_code,
    district,
    reg_id,
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
--select * from ce_districts;