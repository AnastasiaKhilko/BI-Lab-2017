drop sequence seq_emp;
CREATE SEQUENCE seq_emp 
      INCREMENT BY 1
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;
/
GRANT SELECT ON seq_emp TO BL_CL;
