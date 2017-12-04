/**===============================================*\
Name...............:   Sequence for ce_deliveries 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_deliveries;
--**********************************************

CREATE SEQUENCE seq_deliveries INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_deliveries TO bl_cl;