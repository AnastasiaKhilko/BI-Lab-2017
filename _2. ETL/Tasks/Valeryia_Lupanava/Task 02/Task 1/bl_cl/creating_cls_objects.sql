-- Creating tables.
-- Customers.
CREATE TABLE cls_customers
  (
    customer_surr_id NUMBER(10) NOT NULL,
    customer_id      VARCHAR2(40 BYTE) NOT NULL,
    first_name       VARCHAR2(40 BYTE) NOT NULL,
    last_name        VARCHAR2(40 BYTE) NOT NULL,
    age              NUMBER(10) NOT NULL,
    email            VARCHAR2(40 BYTE) NOT NULL,
    phone            VARCHAR2(40 BYTE) NOT NULL,
    address          VARCHAR2(50 BYTE) NOT NULL,
    city             VARCHAR2(50 BYTE) NOT NULL,
    country          VARCHAR2(50 BYTE) NOT NULL,
    start_dt         DATE NOT NULL,
    end_dt           VARCHAR2(20 BYTE) NOT NULL,
    is_active        VARCHAR2(50 CHAR) NOT NULL
  );

CREATE SEQUENCE cls_customers_val
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

    
-- Employees.
CREATE TABLE cls_employees
  (
    employee_surr_id   NUMBER(10) NOT NULL,
    employee_id        VARCHAR2(40 BYTE) NOT NULL,
    employee_desc      VARCHAR2(100 BYTE) NOT NULL,
    first_name         VARCHAR2(40 BYTE) NOT NULL,
    last_name          VARCHAR2(40 BYTE) NOT NULL,
    position_name      VARCHAR2(100 BYTE) NOT NULL,
    email              VARCHAR2(40 BYTE) NOT NULL,
    phone              VARCHAR2(40 BYTE) NOT NULL,
    start_dt           DATE NOT NULL,
    end_dt             VARCHAR2(50 CHAR),
    is_active          VARCHAR2(10) NOT NULL
  );
  
CREATE SEQUENCE cls_employees_val
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
  
-- Products.
CREATE TABLE cls_products
  (
    product_surr_id     NUMBER(10) NOT NULL,
    product_id          VARCHAR2(40 BYTE) NOT NULL,
    product_desc        VARCHAR2(50 BYTE) NOT NULL,
    color               VARCHAR2(40 BYTE) NOT NULL,
    price               VARCHAR2(40 BYTE) NOT NULL,
    start_dt            DATE NOT NULL,
    end_dt              VARCHAR2(50 CHAR) NOT NULL,
    is_active           VARCHAR2(10) NOT NULL
  );
  
CREATE SEQUENCE cls_products_val
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
-- Stores.
CREATE TABLE cls_stores
  (
    store_surr_id NUMBER(10) NOT NULL,
    store_id      VARCHAR2(40 BYTE) NOT NULL,
    store_desc    VARCHAR2(100 BYTE) NOT NULL,
    phone         VARCHAR2(40 BYTE) NOT NULL,
    address       VARCHAR2(100 BYTE) NOT NULL,
    city          VARCHAR2(50 BYTE) NOT NULL,
    country       VARCHAR2(50 BYTE) NOT NULL,
    insert_dt     DATE NOT NULL,
    update_dt     VARCHAR2(50 CHAR) NOT NULL
  );
  
CREATE SEQUENCE cls_stores_val
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;