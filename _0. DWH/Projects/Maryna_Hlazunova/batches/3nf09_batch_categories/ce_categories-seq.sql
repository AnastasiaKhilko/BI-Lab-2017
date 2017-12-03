/**===============================================*\
Name...............:   Sequence for seq_categories 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_categories;
--**********************************************

CREATE SEQUENCE seq_categories INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_categories TO bl_cl;