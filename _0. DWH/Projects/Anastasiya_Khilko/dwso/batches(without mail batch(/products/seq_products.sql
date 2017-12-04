drop sequence seq_products;
CREATE SEQUENCE seq_products 
      INCREMENT BY 1
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;
/
GRANT SELECT ON SEQ_PRODUCTS TO BL_CL;

