drop sequence seq_subcategories;
CREATE SEQUENCE seq_subcategories 
      INCREMENT BY 1
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;
/
GRANT SELECT ON SEQ_SUBCATEGORIES TO BL_CL;