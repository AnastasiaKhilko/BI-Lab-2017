CREATE TABLE CL_PAYMENTS (
    ID_PAYMENT NUMBER(25),
    ID_SALES NUMBER(25),
    ID_PRODUCT NUMBER(15),
    Amount NUMBER(15)
    );
    
CREATE TABLE CL_SALES (
    ID_SALES NUMBER(25),
    ID_CUSTOMER NUMBER(15),
    ID_EMPLOYEE NUMBER(10),
    ID_STORE NUMBER(10),
    DATE_SALES DATE,
    TIME_SALES TIMESTAMP
    );
    

CREATE TABLE CL_PRODUCTS (
    ID_PRODUCT NUMBER(15),
    PROD_NAME VARCHAR2(100),
    PROD_DESC VARCHAR2(3000),
    ID_SUBCATEGORY NUMBER(10),
    PROD_COST NUMBER(15)
    );

CREATE TABLE CL_SUBCATEGORY (
    ID_SUBCATEGORY NUMBER(10),
    SUBCATEGORY_NAME VARCHAR2(100),
    SUBCATEGORY_DESC VARCHAR2(750),
    ID_CATEGORY NUMBER(7)
    );
    
CREATE TABLE CL_CATEGORY (
    ID_CATEGORY NUMBER(7),
    CATEGORY_NAME VARCHAR2(100),
    CATEGORY_DESC VARCHAR2(750)
    );
 
DROP TABLE CL_CUSTOMERS;
CREATE TABLE CL_CUSTOMERS (
    ID_CUSTOMER NUMBER(15),
    FIRST_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(70),
    MOBILE_PHONE VARCHAR2(30),
    EMAIL VARCHAR2(70),
    ID_ADDRESS NUMBER(20),
    START_DT DATE,
    END_DT DATE
    );
    
CREATE TABLE CL_STORES (
    ID_STORES NUMBER(10),
    STORES_DESC VARCHAR2(250),
    ID_ADDRESS NUMBER(20),
    ID_MANAGAER NUMBER(20)
    );
  
  
DROP TABLE CL_EMPLOYEES;
CREATE TABLE CL_EMPLOYEES (
    ID_EMPLOYEE NUMBER(10),
    FIRST_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(70),
    MOBILE_PHONE VARCHAR2(30),
    ID_STORY NUMBER(10),
    ID_JOB NUMBER(5),
    SALARY NUMBER(10),
    MANAGER_ID NUMBER(10),
    START_DT DATE,
    END_DT DATE,
    ID_ADDRESS NUMBER(10),
    EMAIL VARCHAR2(70)
    );
    
CREATE TABLE CL_JOBS (
    ID_JOBS NUMBER(5),
    JOB_NAME VARCHAR2(50),
    JOB_DESC VARCHAR2(250)
    );
    
CREATE TABLE CL_JOB_HISTORY (
    ID_JH NUMBER(15),
    ID_EMPLOYEE NUMBER(10),
    ID_JOB NUMBER(5),
    ID_STORE NUMBER(10),
    SALARY NUMBER(10),
    START_DATE DATE,
    END_DATE DATE
    );


CREATE TABLE CL_ADDRESS (
    ID_ADDRESS NUMBER(20),
    STREET VARCHAR2(50),
    HOUSE NUMBER(5),
    FLAT NUMBER(5),
    PHONE VARCHAR2(30),
    CITY_ID NUMBER(10)
    );

CREATE TABLE CL_CITIES (
    ID_CITY NUMBER(10),
    CITY_NAME VARCHAR2(50),
    ID_COUNTRY NUMBER(10)
    );


 CREATE TABLE CL_COUNTRIES (
    ID_COUNTRY NUMBER(10),
    COUNTRY_NAME VARCHAR2(70),
    COUNTRY_CODE VARCHAR2(10),
    ID_REGION NUMBER(3)
    );
    
CREATE TABLE CL_REGIONS (
    ID_REGION NUMBER(3),
    REGION_NAME VARCHAR2(70),
    ID_CINTINENTS NUMBER(2)
    );

CREATE TABLE CL_CONTINENTS (
    ID_CONTINENT NUMBER(3),
    CONTINENT_NAME VARCHAR(70)
    );
    