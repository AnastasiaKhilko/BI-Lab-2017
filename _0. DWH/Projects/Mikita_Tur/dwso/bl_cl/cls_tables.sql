 DROP TABLE CLS_COUNTRY;
CREATE TABLE CLS_COUNTRY
  (
    COUNTRY_SRCID     NUMBER(8) ,
    COUNTRY_NAME      VARCHAR2 (100)      NOT NULL,
    COUNTRY_CODE      VARCHAR2 (100)         NOT NULL
  );
  
  CREATE TABLE CE_COUNTRY
  (
    COUNTRY_SRCID     NUMBER(8) NOT NULL primary key ,
    COUNTRY_NAME      VARCHAR2 (100)      NOT NULL,
    COUNTRY_CODE      VARCHAR2 (100)         NOT NULL
  );
------------------------------
DROP TABLE CLS_ATE;
CREATE TABLE CLS_ATE
(
   ATE_SRCID     NUMBER (8)         ,
    ATE_NAME      VARCHAR2 (100)      NOT NULL,
    country_code varchar2(100),
    COUNTRY_SRCID NUMBER (8)         
);
------------------------------
DROP TABLE CLS_CITY;
CREATE TABLE CLS_CITY
(
   CITY_SRCID     NUMBER (8)         ,
    CITY     VARCHAR2 (100)      NOT NULL,
    ATE_NAME varchar2(100),
    ATE_SRCID NUMBER (8)         
);
------------------------------
DROP TABLE CLS_ADDRESS;
CREATE TABLE CLS_ADDRESS
(
   ADDRESS_SRCID     NUMBER (8)         ,
    ADDRESS    VARCHAR2 (100),
	POSTAL_CODE VARCHAR2(100),
    CITY varchar2(100),
    CITY_SRCID NUMBER (8)         
);
------------------------------
DROP TABLE CLS_CUSTOMER;
CREATE TABLE CLS_CUSTOMER
  (
    CUSTOMER_SRCID NUMBER (8),
    FIRST_NAME     VARCHAR2 (100),
    MIDDLE_NAME    VARCHAR2 (100),
    LAST_NAME      VARCHAR2 (100),
    AGE            NUMBER (4),
    GENDER         VARCHAR2 (10),
    EMAIL          VARCHAR2 (100),
    PHONE          varchar2 (20),
    address        VARCHAR2(100),
    ADDRESS_SRCID  NUMBER (8)
  );
------------------------------
DROP TABLE cls_product_category;
CREATE TABLE cls_product_category
  (
    category_srcid NUMBER(8),
    category_name  VARCHAR2(100)
  );
------------------------------
drop TABLE cls_product_subcategory ;     
CREATE TABLE cls_product_subcategory
  (
    subcategory_srcid number(8),
    subcategory_name varchar2(100),
    category_srcid NUMBER(8),
    category_name  VARCHAR2(100)
  );
  
  
drop table cls_product;
create table cls_product 
  (
    PRODUCT_SRCID       NUMBER (8)   ,
    PRODUCT_NAME        VARCHAR2 (100),
    PRODUCT_PRICE       NUMBER (8)    ,
    PRODUCT_PACKAGE     VARCHAR2 (100),
    
    SUBCATEGORY_SRCID   NUMBER (8)   ,
    SUPPLIER_SRCID      NUMBER (8)   ,
    START_DT            DATE         ,
    END_DT              DATE         ,
    IS_ACTIVE           VARCHAR2 (10)  
  );