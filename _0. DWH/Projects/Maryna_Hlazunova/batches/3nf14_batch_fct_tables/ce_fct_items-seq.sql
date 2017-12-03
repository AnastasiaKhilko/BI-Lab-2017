/**===============================================*\
Name...............:   Sequence for SEQ_FCT_ITEMS 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   30-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_fct_items;
--**********************************************

CREATE SEQUENCE seq_fct_items INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_fct_items TO bl_cl;