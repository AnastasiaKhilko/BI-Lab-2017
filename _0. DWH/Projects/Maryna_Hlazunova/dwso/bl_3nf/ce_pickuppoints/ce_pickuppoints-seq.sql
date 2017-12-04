/**===============================================*\
Name...............:   Sequence for seq_pickuppoints 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_pickuppoints;
--**********************************************

CREATE SEQUENCE seq_pickuppoints INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_pickuppoints TO bl_cl;