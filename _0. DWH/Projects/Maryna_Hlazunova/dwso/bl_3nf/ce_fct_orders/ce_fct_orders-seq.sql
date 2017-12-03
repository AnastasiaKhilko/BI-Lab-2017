/**===============================================*\
Name...............:   Sequence for seq_fct_orders 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   30-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_fct_orders;
--**********************************************

CREATE SEQUENCE seq_fct_orders INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_fct_orders TO bl_cl;