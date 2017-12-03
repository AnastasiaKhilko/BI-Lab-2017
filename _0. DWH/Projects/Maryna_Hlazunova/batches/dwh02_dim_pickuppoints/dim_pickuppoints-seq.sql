/**===============================================*\
Name...............:   Sequence for dim_paydeliveries BL_DWH layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP SEQUENCE seq_pickuppoints;
--**********************************************

CREATE SEQUENCE seq_pickuppoints INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_pickuppoints TO bl_cl_dwh;