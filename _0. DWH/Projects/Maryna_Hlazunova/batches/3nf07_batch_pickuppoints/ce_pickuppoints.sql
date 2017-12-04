/**===============================================*\
Name...............:   Normalized table ce_pickuppoints 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE ce_pickuppoints;
--**********************************************

CREATE TABLE ce_pickuppoints (
    point_id        NUMBER(3) PRIMARY KEY,
    nat_code        VARCHAR2(3 CHAR),
    point_loc_id    NUMBER(6),
    point_address   VARCHAR2(250),
    insert_dt       DATE,
    update_dt       DATE,
    CONSTRAINT fk_pp_loc_id FOREIGN KEY ( point_loc_id )
        REFERENCES ce_localities ( loc_id )
);
--**********************************************

INSERT INTO bl_3nf.ce_pickuppoints (
    point_id,
    nat_code,
    point_loc_id,
    point_address,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    -98,
    'N/D',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_pickuppoints (
    point_id,
    nat_code,
    point_loc_id,
    point_address,
    insert_dt,
    update_dt
) VALUES (
    -99,
    'N/A',
    -99,
    'N/A',
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

COMMIT;
--**********************************************
--select * from ce_pickuppoints;