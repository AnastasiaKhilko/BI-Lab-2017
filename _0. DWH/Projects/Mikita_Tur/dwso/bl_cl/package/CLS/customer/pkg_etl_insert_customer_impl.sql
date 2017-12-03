CREATE OR REPLACE PACKAGE BODY PKG_ETL_INSERT_customer
AS
  PROCEDURE INSERT_TABLE_customer
  IS
  BEGIN
    EXECUTE IMMEDIATE ('TRUNCATE TABLE CLS_CUSTOMER');
    INSERT
    INTO CLS_CUSTOMER
      (
        FIRST_NAME,
        MIDDLE_NAME ,
        LAST_NAME ,
        AGE ,
        GENDER ,
        EMAIL ,
        PHONE ,
        address
      )
    SELECT GIVENNAME,
      MIDDLEINITIAL,
      SURNAME,
      AGE,
      GENDER,
      EmailAddress,
      (TelephoneCountryCode
      ||
      TelephoneNumber) ,
      streetaddress
    FROM WRK_customers ;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END INSERT_TABLE_customer;
---
  PROCEDURE MERGE_TABLE_customer
  IS
  BEGIN
    MERGE INTO bl_3nf.ce_customer NFcust USING
    (SELECT CUSTOMER_SRCID ,
      FIRST_NAME ,
      MIDDLE_NAME ,
      LAST_NAME ,
      AGE ,
      GENDER ,
      EMAIL ,
      PHONE ,
      ad.ADDRESS_SRCID 
    FROM CLS_customer CUST,
      BL_3NF.CE_address AD
    WHERE cust.address = ad.address
    MINUS
    SELECT CUSTOMER_SRCID ,
      FIRST_NAME ,
      MIDDLE_NAME ,
      LAST_NAME ,
      AGE ,
      GENDER ,
      EMAIL ,
      PHONE ,
      ADDRESS_SRCID
    FROM bl_3nf.ce_customer
    ) CLSCU ON (CLSCU.address_SRCID =NFcust.address_SRCID)
  WHEN MATCHED THEN
    UPDATE SET NFcust.email = CLScu.email WHEN NOT MATCHED THEN
    INSERT
      (
        CUSTOMER_SRCID ,
        FIRST_NAME ,
        MIDDLE_NAME ,
        LAST_NAME ,
        AGE ,
        GENDER ,
        EMAIL ,
        PHONE ,
        ADDRESS_SRCID
      )
      VALUES
      (
        bl_3nf.cust_SEQ.NEXTVAL,
        CLScu.FIRST_NAME ,
        CLScu.MIDDLE_NAME ,
        CLScu.LAST_NAME ,
        CLScu.AGE ,
        CLScu.GENDER ,
        CLScu.EMAIL ,
        CLScu.PHONE ,
        CLScu.ADDRESS_SRCID
      );
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE ;
  END MERGE_TABLE_customer;
END PKG_ETL_INSERT_customer;
/