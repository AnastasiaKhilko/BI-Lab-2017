create table products
  (
    prod_id number(8),
    prod_code varchar2(10),
    prod_name varchar2(100 char),
    category_id number(8),
    prod_price number(8)
  );

  
  CREATE SEQUENCE prod_seq START WITH 100 INCREMENT BY 1 NOCACHE NOCYCLE;


 insert into products (prod_id,prod_code, prod_name, category_id, prod_price)
SELECT
    prod_seq.nextval AS PROD_ID,
    DBMS_RANDOM.STRING('Z',DBMS_RANDOM.VALUE(2,10)) AS PROD_CODE,
   sh.Products.Prod_name as prod_name,
    ROUND(DBMS_RANDOM.VALUE ( 1, ( select max (Prod_category_id) from sh.Products))) AS CATEGORY_ID,
    ROUND(DBMS_RANDOM.VALUE ( 1, ( select max (Prod_list_price) from sh.Products))) as prod_price
    FROM sh.products 
  , ( SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= 10);

COMMIT;