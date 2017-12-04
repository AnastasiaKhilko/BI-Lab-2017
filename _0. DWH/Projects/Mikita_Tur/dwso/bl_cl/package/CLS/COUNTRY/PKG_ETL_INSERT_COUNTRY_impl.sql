
CREATE OR REPLACE PACKAGE BODY PKG_ETL_INSERT_COUNTRY
AS
  PROCEDURE INSERT_TABLE_COUNTRY
    IS
    BEGIN 
    EXECUTE IMMEDIATE ('TRUNCATE TABLE CLS_COUNTRY');
    INSERT INTO CLS_COUNTRY(country_name, country_code) 
    SELECT COUN.COUNTRY_NAME,COUN.CC_FIPS
    FROM WRK_COUNTRIES COUN LEFT JOIN WRK_CUSTOMERS COS
    ON (COUN.COUNTRY_NAME = COS.COUNTRYFULL );
    COMMIT;
    EXCEPTION WHEN OTHERS THEN RAISE;
  END INSERT_TABLE_COUNTRY;
---  
  PROCEDURE MERGE_TABLE_COUNTRY
  IS 
  BEGIN 
  MERGE INTO bl_3nf.ce_country CEC using
    (SELECT 
      COUNTRY_SRCID,
      COUNTRY_NAME,
      COUNTRY_CODE
        FROM CLS_COUNTRY
    MINUS
     SELECT 
      COUNTRY_SRCID,
      COUNTRY_NAME,
      COUNTRY_CODE
    FROM bl_3nf.ce_country
    ) CLSC ON (CLSC.COUNTRY_SRCID = CEC.COUNTRY_SRCID)
  WHEN MATCHED THEN 
    UPDATE SET CEC.COUNTRY_NAME = CLSC.COUNTRY_NAME
  WHEN NOT MATCHED THEN
    INSERT 
      (
        COUNTRY_SRCID,
        COUNTRY_NAME,
        COUNTRY_CODE 
      )
    VALUES
      (
        bl_3nf.COUNTRY_SEQ.NEXTVAL,
        CLSC.COUNTRY_NAME,
        CLSC.COUNTRY_CODE
      );
    COMMIT;
  EXCEPTION 
    WHEN OTHERS THEN RAISE ;
  END MERGE_TABLE_COUNTRY;
END PKG_ETL_INSERT_COUNTRY;
/