/**===============================================*\
Name...............:   Normalized table ce_payoptions 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE ce_payoptions;
--**********************************************

CREATE TABLE ce_payoptions (
    pay_id      NUMBER(2) PRIMARY KEY,
    nat_code    VARCHAR2(3 CHAR),
    payoption   VARCHAR2(100 CHAR),
    insert_dt   DATE,
    update_dt   DATE
);
--**********************************************

INSERT INTO bl_3nf.ce_payoptions (
    pay_id,
    nat_code,
    payoption,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_payoptions (
    pay_id,
    nat_code,
    payoption,
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
--select * from ce_payoptions;