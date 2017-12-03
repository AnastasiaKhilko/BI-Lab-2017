/**===============================================*\
Name...............:   Sequence for seq_products 3NF layer
Contents...........:   Create sequence description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_products;
--**********************************************

CREATE SEQUENCE seq_products INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_products TO bl_cl;