/**===============================================*\
Name...............:   Sequence for seq_brands 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_brands;
--**********************************************

CREATE SEQUENCE seq_brands INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_brands TO bl_cl;