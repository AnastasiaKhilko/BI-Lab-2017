-- Creating tables.
-- Customers.
    CREATE TABLE wrk_customers
        (passport_number  VARCHAR2(50 CHAR),
         first_name       VARCHAR2(50 CHAR),
         last_name        VARCHAR2(50 CHAR),
         gender           VARCHAR2(50 CHAR),
         age              NUMBER(10),
         email            VARCHAR2(50 CHAR),
         phone            VARCHAR2(50 CHAR),
         postal_code      VARCHAR2(50 CHAR),
         address          VARCHAR2(50 CHAR),
         city             VARCHAR2(50 CHAR),
         country_code     VARCHAR2(50 CHAR),
         country          VARCHAR2(50 CHAR),
         is_active        VARCHAR2(50 CHAR)
         );

    
-- Employees.
CREATE TABLE wrk_employees
  (
    employee_code        VARCHAR2(50 CHAR),
    first_name           VARCHAR2(50 CHAR),
    last_name            VARCHAR2(50 CHAR),
    age                  NUMBER(38),
    store_srcid          NUMBER(38),
    position_name        VARCHAR2(100 CHAR),
    position_grade_srcid VARCHAR2(100 CHAR),
    work_experience      NUMBER(38),
    email                VARCHAR2(100 CHAR),
    phone                VARCHAR2(100 CHAR),
    personal_address     VARCHAR2(100 CHAR),
    currency             VARCHAR2(50 CHAR),
    currency_code        VARCHAR2(50 CHAR),
    month_salary         VARCHAR2(50 CHAR),
    credit_card          NUMBER(38),
    start_date           DATE,
    end_date             VARCHAR2(50 CHAR),
    is_active            VARCHAR2(50 CHAR)
  );
  
-- Products.
CREATE TABLE wrk_products
  (
    product_id          VARCHAR2(100 BYTE),
    product_desc        VARCHAR2(100 BYTE),
    color               VARCHAR2(40 BYTE),
    price               VARCHAR2(40 BYTE),
    start_dt            DATE,
    end_dt              VARCHAR2(50 CHAR),
    is_active           VARCHAR2(10 BYTE)
  );
 
-- Stores.
CREATE TABLE wrk_stores
  (
    store_id     VARCHAR2(40 BYTE),
    store_desc   VARCHAR2(100 BYTE),
    phone        VARCHAR2(40 BYTE),
    address      VARCHAR2(100 BYTE),
    city         VARCHAR2(50 BYTE),
    country      VARCHAR2(50 BYTE),
    insert_dt    DATE,
    update_dt    VARCHAR2(50 CHAR)
  );