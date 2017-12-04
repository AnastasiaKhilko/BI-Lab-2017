/**===============================================*\
Name...............:   Sequence for seq_localities 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   28-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_types;
--**********************************************

CREATE SEQUENCE seq_types INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_types TO bl_cl;