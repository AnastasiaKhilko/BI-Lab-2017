/**===============================================*\
Name...............:   Sequence for ce_districts 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_districts;
--**********************************************

CREATE SEQUENCE seq_districts INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_districts TO bl_cl;