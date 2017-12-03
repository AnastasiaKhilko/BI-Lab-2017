/**===============================================*\
Name...............:   Sequence for seq_customers BL_DWH layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP SEQUENCE seq_customers;
--**********************************************

CREATE SEQUENCE seq_customers INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_customers TO bl_cl_dwh;