/**===============================================*\
Name...............:   Sequence for seq_colors 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   29-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_colors;
--**********************************************

CREATE SEQUENCE seq_colors INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_colors TO bl_cl;