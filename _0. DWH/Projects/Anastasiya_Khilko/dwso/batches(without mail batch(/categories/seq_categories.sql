drop sequence seq_categories;
CREATE SEQUENCE seq_categories 
      INCREMENT BY 1
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;
/
GRANT SELECT ON SEQ_CATEGORIES TO BL_CL;