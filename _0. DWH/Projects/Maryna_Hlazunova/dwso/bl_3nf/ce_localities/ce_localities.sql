/**===============================================*\
Name...............:   Normalized table ce_localities 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   24-Nov-2017
\*=============================================== */
DROP TABLE ce_localities;
--**********************************************

CREATE TABLE ce_localities (
    loc_id          NUMBER(6) PRIMARY KEY,
    loc_code        VARCHAR2(6 CHAR),
    loc_type_id     NUMBER(2),
    location_name   VARCHAR2(100 CHAR),
    dis_id          NUMBER(3),
    insert_dt       DATE,
    update_dt       DATE,
    CONSTRAINT fk_cl_loc_type_id FOREIGN KEY ( loc_type_id )
        REFERENCES ce_loc_types ( loc_type_id ),
    CONSTRAINT fk_cl_dis_id FOREIGN KEY ( dis_id )
        REFERENCES ce_districts ( dis_id )
);
--**********************************************

INSERT INTO bl_3nf.ce_localities (
    loc_id,
    loc_code,
    loc_type_id,
    location_name,
    dis_id,
    insert_dt,
    update_dt
) VALUES (
    -98,
    'N/D',
    -98,
    'N/D',
    -98,
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

INSERT INTO bl_3nf.ce_localities (
    loc_id,
    loc_code,
    loc_type_id,
    location_name,
    dis_id,
    insert_dt,
    update_dt
) VALUES (
    -99,
    'N/A',
    -99,
    'N/A',
    -99,
    TO_DATE('01/01/1900','DD/MM/YYYY'),
    TO_DATE('01/01/1900','DD/MM/YYYY')
);

COMMIT;

--**********************************************
--select * from ce_localities;