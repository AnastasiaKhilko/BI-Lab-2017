drop sequence seq_stores;
CREATE SEQUENCE seq_stores 
      INCREMENT BY 1
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;
/
GRANT SELECT ON seq_stores TO BL_CL;
