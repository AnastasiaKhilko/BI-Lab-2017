DROP SEQUENCE seq_products;

CREATE SEQUENCE seq_products INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
--\*=============================================== */
CREATE TABLE FCT_SALES
  ( SALES_ID   NUMBER PRIMARY KEY,
    SALES_DATE DATE,
    PRODUCT_ID VARCHAR2 (8),
    EMPLOYEE_ID VARCHAR2 (6),
    CUSTOMER_ID NUMBER,
    COUNTRY_ID NUMBER(5,0),
    PROMO_ID NUMBER(6,0),
    SUMM     NUMBER ,
    AMOUNT  NUMBER,
    DISCOUNT NUMBER
  ) ;
  
  
 