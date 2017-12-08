CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CUSTOMERS AUTHID CURRENT_USER
AS
  PROCEDURE LOAD_WRK_CUSTOMERS;
  PROCEDURE INSERT_TABLE_CUSTOMERS;
  PROCEDURE MERGE_TABLE_CE_CUSTOMERS;
END PKG_LOAD_3NF_CUSTOMERS;
/
CREATE OR REPLACE PACKAGE BODY PKG_LOAD_3NF_CUSTOMERS
AS
  ---------------------------------------------------
PROCEDURE LOAD_WRK_CUSTOMERS
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_customers';
  INSERT INTO WRK_CUSTOMERS
  SELECT * FROM SA_SRC.EXT_CUSTOMERS;
  COMMIT;
  -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END LOAD_WRK_CUSTOMERS;
PROCEDURE INSERT_TABLE_CUSTOMERS
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_customers');
  INSERT
  INTO CLS_CUSTOMERS
    (
      CUSTOMER_ID ,
      GENDER ,
      NAME,
      SURNAME,
      TITLE,
      EMAIL ,
      PHONE ,
      AGE ,
      AGE_GROUP ,
      BIRTHDAY,-- WF
      OCCUPATION ,
      COMPANY ,
      ADDRESS_ID,
      UPDATE_DT
    )
  SELECT --cls_customers_seq.NEXTVAL AS customer_id,
    TO_NUMBER(NUMBER_ID) AS CUSTOMER_ID,
    GENDER,
    --NameSet VARCHAR2 (250 CHAR),
    GIVENNAME,
    SURNAME,
    TITLE,
    EMAILADDRESS,
    -- Username,
    TELEPHONENUMBER,
    TO_NUMBER(AGE),
    (
    CASE
      WHEN TO_NUMBER(AGE) >= 18
      AND TO_NUMBER(AGE)   <25
      THEN 'young adult'
      WHEN TO_NUMBER(AGE) <35
      THEN 'adult'
      WHEN TO_NUMBER(AGE) <45
      THEN 'middle aged adult'
      WHEN TO_NUMBER(AGE) <55
      THEN 'aged adult'
      WHEN TO_NUMBER(AGE) >= 55
      THEN 'seniot citizen'
    END) AS AGE_CATEGORY_ID,
    TO_DATE(BIRTHDAY,'MM/DD/YYYY'), --WF
    OCCUPATION,
    COMPANY,
    ADDRESS_ID,
    --         (case when age >= 18 and age <25 then 1
    --               when age >= 25 and age <35 then 2
    --               when age >= 35 and age <45 then 3
    --               when age >= 45 and age <55 then 4
    --               when age >= 55 then 5
    --          end) as age_category_id
    SYSDATE AS UPDATE_DT
  FROM WRK_CUSTOMERS CU
  LEFT JOIN BL_3NF.CE_ADDRESSES AD
  ON CU.STREETADDRESS = AD.ADDRESS;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END INSERT_TABLE_CUSTOMERS;
-----------------------------------------------------
-----------------------------------------------------
PROCEDURE MERGE_TABLE_CE_CUSTOMERS
IS
BEGIN
  MERGE INTO BL_3NF.CE_CUSTOMERS CE USING
  (SELECT CUSTOMER_ID,
    GENDER ,
    NAME,
    SURNAME,
    TITLE,
    EMAIL,
    PHONE,
    AGE,
    AGE_GROUP,
    BIRTHDAY,
    OCCUPATION,
    COMPANY,
    CUST.ADDRESS_ID
  FROM CLS_CUSTOMERS CUST
  LEFT JOIN BL_3NF.CE_ADDRESSES AD
  ON CUST.ADDRESS_ID = AD.ADDRESS_ID
  MINUS
  SELECT CUSTOMER_ID,
    GENDER,
    NAME,
    SURNAME,
    TITLE,
    EMAIL,
    TELEPHONE_NUMBER,
    AGE,
    AGE_GROUP,
    BIRTHDAY,
    OCCUPATION,
    COMPANY,
    --address_id number references dim_addresses(address_id),
    ADDRESS_ID
    --end_dt,
    --is_active
    --start_dt,
  FROM BL_3NF.CE_CUSTOMERS
  ) CLS ON ( CE.CUSTOMER_ID = CLS.CUSTOMER_ID )
WHEN MATCHED THEN
  UPDATE
  SET --t.end_dt  = c.end_dt,
    --t.is_active = c.is_active
    --  ce.CUSTOMER_ID= cls.CUSTOMER_ID,
    CE.GENDER     =CLS.GENDER ,
    CE.NAME       = CLS.NAME,
    CE.SURNAME    = CLS.SURNAME,
    CE.TITLE      = CLS.TITLE,
    CE.EMAIL      = CLS.EMAIL,
    CE.AGE_GROUP  = CLS.AGE_GROUP,
    CE.AGE        = CLS.AGE,
    CE.BIRTHDAY   = CLS.BIRTHDAY,
    CE.ADDRESS_ID = CLS.ADDRESS_ID,
    CE.UPDATE_DT  = SYSDATE WHEN NOT MATCHED THEN
  INSERT
    (
      CUSTOMER_3NF_ID,
      CUSTOMER_ID,
      GENDER ,
      NAME ,
      SURNAME,
      TITLE ,
      EMAIL ,
      TELEPHONE_NUMBER,
      AGE,
      AGE_GROUP ,
      BIRTHDAY,
      OCCUPATION ,
      COMPANY,
      ADDRESS_ID,-- number references dim_addresses(address_id),
      UPDATE_DT
      --start_dt,
      --end_dt,
      --is_active
    )
    VALUES
    (
      BL_3NF.SEQ_CUSTOMERS_3NF.NEXTVAL,
      CLS.CUSTOMER_ID,
      CLS.GENDER ,
      CLS.NAME,
      CLS.SURNAME,
      CLS.TITLE,
      CLS.EMAIL,
      CLS.PHONE,
      CLS.AGE,
      CLS.AGE_GROUP ,
      CLS.BIRTHDAY,
      CLS.OCCUPATION,
      CLS.COMPANY,
      CLS.ADDRESS_ID,
      SYSDATE
      --  c.start_dt,
      --c.end_dt,
      --c.is_active
    ) ;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END MERGE_TABLE_CE_CUSTOMERS;
---------------------------------------------------
END PKG_LOAD_3NF_CUSTOMERS;
/
--BEGIN
--  --pkg_load_3nf_customers.insert_table_customers;
--  PKG_LOAD_3NF_CUSTOMERS.LOAD_WRK_CUSTOMERS;
--  PKG_LOAD_3NF_CUSTOMERS.INSERT_TABLE_CUSTOMERS;
--  PKG_LOAD_3NF_CUSTOMERS.MERGE_TABLE_CE_CUSTOMERS;
--END;
--/
--EXEC PKG_LOAD_3NF_CUSTOMERS.LOAD_WRK_CUSTOMERS;
--EXEC PKG_LOAD_3NF_CUSTOMERS.INSERT_TABLE_CUSTOMERS;
--EXEC PKG_LOAD_3NF_CUSTOMERS.MERGE_TABLE_CE_CUSTOMERS;

--to_date(Birthday,'MM/DD/YYYY')
--from wrk_customers;
--select * from cls_customers;
--truncate table bl_3nf.ce_customers;
--select * from  bl_3nf.ce_customers;