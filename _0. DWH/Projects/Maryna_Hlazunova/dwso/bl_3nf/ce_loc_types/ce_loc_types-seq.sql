/**===============================================*\
Name...............:   Sequence for seq_loc_types 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   26-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_loc_types;
--**********************************************

CREATE SEQUENCE seq_loc_types INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_loc_types TO bl_cl;