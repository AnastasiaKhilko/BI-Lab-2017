/**===============================================*\
Name...............:   Normalized table ce_customers 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   25-Nov-2017
\*=============================================== */
DROP TABLE ce_customers;
--**********************************************

CREATE TABLE ce_customers (
    customer_id         NUMBER(12) PRIMARY KEY,
    customer_code       NUMBER(8),
    last_name           VARCHAR2(50 CHAR),
    first_name          VARCHAR2(50 CHAR),
    middle_name         VARCHAR2(50 CHAR),
    birthdate           DATE,
    gender              VARCHAR2(3 CHAR),
    personal_discount   NUMBER(2),
    cust_loc_id         NUMBER(6),
    locality_address    VARCHAR2(100 CHAR),
    start_dt            DATE,
    end_dt              DATE,
    is_active           VARCHAR2(1 CHAR),
    CONSTRAINT fk_cu_loc_id FOREIGN KEY ( cust_loc_id )
        REFERENCES ce_localities ( loc_id )
);
--**********************************************

INSERT INTO bl_3nf.ce_customers (
    customer_id,
    customer_code,
    last_name,
    first_name,
    middle_name,
    birthdate,
    gender,
    personal_discount,
    cust_loc_id,
    locality_address,
    start_dt,
    end_dt,
    is_active
) VALUES (
    -98,
    -98,
    'N/D',
    'N/D',
    'N/D',
    NULL,
    'N/D',
    NULL,
    -98,
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    'Y'
);

INSERT INTO bl_3nf.ce_customers (
    customer_id,
    customer_code,
    last_name,
    first_name,
    middle_name,
    birthdate,
    gender,
    personal_discount,
    cust_loc_id,
    locality_address,
    start_dt,
    end_dt,
    is_active
) VALUES (
    -99,
    -99,
    'N/D',
    'N/D',
    'N/D',
    NULL,
    'N/D',
    NULL,
    -99,
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    'Y'
);

COMMIT;
--**********************************************
-- select * from ce_customers;