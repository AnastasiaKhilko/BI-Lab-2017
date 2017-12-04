drop sequence seq_customers;
CREATE SEQUENCE seq_customers 
      INCREMENT BY 1
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;
/
GRANT SELECT ON seq_customers TO BL_CL;
