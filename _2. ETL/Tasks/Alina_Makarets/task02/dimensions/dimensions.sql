CREATE SEQUENCE seq_customers
INCREMENT BY 1 
START WITH 1 
MINVALUE 1 
NOCYCLE;

CREATE TABLE dim_customers AS
SELECT seq_customers.nextval as customer_id,
       cust_first_name as first_name,
       cust_last_name as last_name,
       date_of_birth,
       marital_status,
       gender
FROM oe.customers;

SELECT * FROM dim_customers;
---------------------------------------------------------------------------------
CREATE SEQUENCE seq_products
INCREMENT BY 1 
START WITH 1 
MINVALUE 1 
NOCYCLE;

CREATE TABLE dim_products AS
SELECT seq_products.nextval as product_id,
       p.product_name,
       nvl(p.list_price,0) as list_price,
       cat.category_id,
       cat.category_name
FROM oe.products p JOIN oe.categories_tab c ON p.category_id=c.category_id
  JOIN oe.categories_tab cat ON cat.category_id = c.parent_category_id;

SELECT * FROM DIM_PRODUCTS;
---------------------------------------------------------------------------------
CREATE TABLE DIM_TIME_DAY (
        Date_id DATE NOT NULL,
        Day_of_week NUMBER(2) NOT NULL,
        Day_name_of_week VARCHAR2(25) NOT NULL,
        Day_of_month NUMBER(8) NOT NULL,
        Day_of_year NUMBER(8) NOT NULL,
        Week_of_month NUMBER(8) NOT NULL,
        Week_of_year NUMBER(8) NOT NULL,
        Month_number NUMBER(8) NOT NULL,
        Month_name VARCHAR2(20) NOT NULL,
        Quarter NUMBER(2) NOT NULL,
        First_day_of_month DATE NOT NULL,
        Last_day_of_month DATE NOT NULL,
        Year NUMBER(8) NOT NULL,
        Year_Quater VARCHAR2(25) NOT NULL,
        CONSTRAINT PK_DATE_ID
          PRIMARY KEY (Date_id)
        );
        
INSERT INTO  DIM_TIME_DAY 
SELECT TO_DATE(SYSDATE+rownum-365*7,'DD-MM-YYYY') as Date_id, 
       to_number(to_char(SYSDATE+rownum-365*7-1, 'D')) as Day_of_week,
       to_char(SYSDATE+rownum-365*7,'Day','NLS_DATE_LANGUAGE = RUSSIAN') AS Day_name_of_week,       
       to_number(to_char(extract(day from SYSDATE+rownum-365*7)))as Day_of_month,
       to_number(to_char(SYSDATE+rownum-365*7, 'DDD')) AS Day_of_year,
       to_number(to_char(SYSDATE+rownum-365*7, 'W')) AS Week_of_month,
       to_number(to_char(SYSDATE+rownum-365*7, 'IW')) AS Week_of_year,
       to_number(to_char(extract(month from SYSDATE+rownum-365*7))) as Month_number,
       to_char(SYSDATE+rownum-365*7, 'MONTH', 'NLS_DATE_LANGUAGE=Russian') AS Month_name,
       to_number(to_char(SYSDATE+rownum-365*7, 'Q')) AS Quarter,
       to_date(last_day(SYSDATE+rownum-365*7)+1,'DD-MM-YYYY') AS First_day_of_month,
       to_date(last_day(SYSDATE+rownum-365*7),'DD-MM-YYYY') AS Last_day_of_month,
       to_number(to_char(extract(year from SYSDATE+rownum-365*7))) as Year,
       to_char(extract(year from SYSDATE+rownum-365*7) || ' '|| to_char(SYSDATE+rownum-365*7, 'Q') || ' ' ||'???????') as "Year-Quater"
FROM dual
CONNECT BY rownum <=365*7;
commit;
SELECT * FROM DIM_TIME_DAY;  
---------------------------------------------------------------------------------
CREATE SEQUENCE seq_stores
INCREMENT BY 1 
START WITH 1 
MINVALUE 1 
NOCYCLE;

CREATE TABLE dim_stores AS
SELECT seq_stores.nextval as store_id,
       country_id,
       country_name,
       country_subregion,
       country_subregion_id,
       country_region,
       country_region_id
FROM sh.countries;

SELECT * FROM dim_stores;

