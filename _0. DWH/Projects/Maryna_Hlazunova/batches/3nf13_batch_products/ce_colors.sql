/**===============================================*\
Name...............:   Table ce_colors BL_3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   29-Nov-2017
\*=============================================== */
DROP TABLE ce_colors;
--**********************************************

CREATE TABLE ce_colors (
    color_id     NUMBER(3) PRIMARY KEY,
    color_desc   VARCHAR2(20 CHAR),
    insert_dt    DATE,
    update_dt    DATE
);
--**********************************************

INSERT INTO bl_3nf.ce_colors (
    color_id,
    color_desc,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_colors (
    color_id,
    color_desc,
    insert_dt,
    update_dt
) VALUES (
    -99,
    'N/A',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

COMMIT;
--**********************************************
-- select * from ce_colors;