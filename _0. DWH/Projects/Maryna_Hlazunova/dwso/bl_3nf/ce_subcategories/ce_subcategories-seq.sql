/**===============================================*\
Name...............:   Sequence for seq_subcategories 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   28-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_subcategories;
--**********************************************

CREATE SEQUENCE seq_subcategories INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_subcategories TO bl_cl;