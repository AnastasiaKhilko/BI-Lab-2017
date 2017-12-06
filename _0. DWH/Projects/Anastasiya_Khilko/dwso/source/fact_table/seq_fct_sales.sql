DROP SEQUENCE seq_fct_sales;
--**********************************************

CREATE SEQUENCE seq_fct_sales INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

GRANT SELECT ON seq_fct_sales TO bl_cl;