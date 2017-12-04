/**===============================================*\
Name...............:   Sequence for dim_paydeliveries BL_DWH layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP SEQUENCE seq_paydeliveries;
--**********************************************

CREATE SEQUENCE seq_paydeliveries INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_paydeliveries TO bl_cl_dwh;