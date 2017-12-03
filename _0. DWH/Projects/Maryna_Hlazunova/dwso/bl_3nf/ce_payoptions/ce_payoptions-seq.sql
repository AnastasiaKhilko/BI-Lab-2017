/**===============================================*\
Name...............:   Sequence for ce_payoptions 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_payoptions;
--**********************************************

CREATE SEQUENCE seq_payoptions INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_payoptions TO bl_cl;