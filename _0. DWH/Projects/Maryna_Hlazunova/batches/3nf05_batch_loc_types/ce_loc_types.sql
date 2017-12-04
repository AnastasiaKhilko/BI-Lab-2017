/**===============================================*\
Name...............:   Normalized table ce_loc_types 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   26-Nov-2017
\*=============================================== */
DROP TABLE ce_loc_types;
--**********************************************

CREATE TABLE ce_loc_types (
    loc_type_id      NUMBER(2) PRIMARY KEY,
    loc_type_short   VARCHAR2(10 CHAR),
    loc_type_full    VARCHAR2(25 CHAR),
    insert_dt        DATE,
    update_dt        DATE
);
--**********************************************

INSERT INTO bl_3nf.ce_loc_types (
    loc_type_id,
    loc_type_short,
    loc_type_full,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_loc_types (
    loc_type_id,
    loc_type_short,
    loc_type_full,
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

-- SELECT * FROM ce_loc_types;