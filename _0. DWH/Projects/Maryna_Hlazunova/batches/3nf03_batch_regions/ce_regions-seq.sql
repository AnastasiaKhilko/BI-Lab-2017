/**===============================================*\
Name...............:   Sequence for seq_regions 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_regions;
--**********************************************

CREATE SEQUENCE seq_regions INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_regions TO bl_cl;