drop sequence seq_providers;
CREATE SEQUENCE seq_providers 
      INCREMENT BY 1
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;
/
GRANT SELECT ON seq_providers TO BL_CL;
