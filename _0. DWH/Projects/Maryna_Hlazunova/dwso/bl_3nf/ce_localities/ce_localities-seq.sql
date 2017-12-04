/**===============================================*\
Name...............:   Sequence for seq_localities 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_localities;
--**********************************************

CREATE SEQUENCE seq_localities INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_localities TO bl_cl;