---------------------------------------------------------------------------------------------
-- DATA WAREHOUSE LAYER ---------------------------------------------------------------------
---------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE DWH_DDL
  AUTHID CURRENT_USER as
  PROCEDURE DIM_CONSUMERS;
  PROCEDURE DIM_DEPARTMENTS;
  PROCEDURE DIM_PRODUCTS;
  PROCEDURE DIM_PROMOTIONS;
  PROCEDURE FCT_SALES;

END DWH_DDL;
/

CREATE OR REPLACE PACKAGE BODY DWH_DDL AS 

-- dim_Consumers 
PROCEDURE DIM_CONSUMERS AS
BEGIN
MERGE INTO dim_consumers dim
USING ( SELECT * FROM cls_consumers 
        MINUS
        SELECT CONSUMER_ID, CONSUMER_DESC, RATE_ID, RATE_DESC, RESPONSIBLE_ID, RESPONSIBLE_DESC, ADDRESS_ID, ADDRESS_DESC, CITY_ID, CITY_DESC, COUNTRY_ID, COUNTRY_DESC, SUBREGION_ID, SUBREGION_DESC, REGION_ID, REGION_DESC, POSTAL_CODE, PHONE,UPDATE_DT,INSERT_DT
        FROM dim_consumers) cl
  ON (cl.consumer_id = dim.consumer_id AND
      cl.RESPONSIBLE_ID = dim.RESPONSIBLE_ID AND
      cl.RATE_ID =  dim.RATE_ID AND
      cl.ADDRESS_ID = dim.ADDRESS_ID
       )
WHEN MATCHED
  THEN UPDATE
    SET
      dim.CONSUMER_DESC = cl.CONSUMER_DESC,
      dim.RATE_DESC = cl.RATE_DESC,
      dim.RESPONSIBLE_DESC = cl.RESPONSIBLE_DESC,
      dim.ADDRESS_DESC = cl.ADDRESS_DESC,
      dim.CITY_ID =  cl.CITY_ID,
      dim.CITY_DESC = cl.CITY_DESC,
      dim.COUNTRY_ID = cl.COUNTRY_ID,
      dim.COUNTRY_DESC = cl.COUNTRY_DESC,
      dim.SUBREGION_ID = cl.SUBREGION_ID,
      dim.SUBREGION_DESC = cl.SUBREGION_DESC,
      dim.REGION_ID = cl.REGION_ID,
      dim.REGION_DESC = cl.REGION_DESC,
      dim.POSTAL_CODE = cl.POSTAL_CODE,
      dim.PHONE = cl.PHONE,
      dim.UPDATE_DT = sysdate
WHEN NOT MATCHED 
  THEN INSERT
    VALUES (
      seq_dconsumers.nextval,
      cl.CONSUMER_ID,
      cl.CONSUMER_DESC,
      cl.RATE_ID,
      cl.RATE_DESC,
      cl.RESPONSIBLE_ID,
      cl.RESPONSIBLE_DESC,
      cl.ADDRESS_ID,
      cl.ADDRESS_DESC,
      cl.CITY_ID,
      cl.CITY_DESC,
      cl.COUNTRY_ID,
      cl.COUNTRY_DESC,
      cl.SUBREGION_ID,
      cl.SUBREGION_DESC,
      cl.REGION_ID,
      cl.REGION_DESC,
      cl.POSTAL_CODE,
      cl.PHONE,
      sysdate,
      sysdate);
COMMIT;
END;

-- dim_Departments 
PROCEDURE DIM_DEPARTMENTS AS
BEGIN
MERGE INTO dim_departments dim 
USING( SELECT * FROM cls_departments ) cl
  ON (
    dim.department_id = cl.department_id AND
    dim.address_id = cl.address_id )
  WHEN MATCHED 
    THEN UPDATE
      SET 
          dim.DEPARTMENT_DESC = cl.DEPARTMENT_DESC,
          dim.ADDRESS_DESC    = cl.ADDRESS_DESC,
          dim.CITY_ID         = cl.CITY_ID,
          dim.CITY_DESC       = cl.CITY_DESC,
          dim.COUNTRY_ID      = cl.COUNTRY_ID,
          dim.COUNTRY_DESC    = cl.COUNTRY_DESC,
          dim.SUBREGION_ID    = cl.SUBREGION_ID,
          dim.SUBREGION_DESC  = cl.SUBREGION_DESC,
          dim.REGION_ID       = cl.REGION_ID,
          dim.REGION_DESC     = cl.REGION_DESC,
          dim.PHONE           = cl.PHONE,
          dim.POSTAL_CODE     = cl.POSTAL_CODE,
          dim.START_DT        = cl.START_DT,
          dim.END_DT          = cl.END_DT,
          dim.IS_ACTIVE       = cl.is_active,
          dim.UPDATE_DT       = sysdate
  WHEN NOT MATCHED
    THEN INSERT VALUES (
      seq_ddepartments.nextval,
      cl.DEPARTMENT_ID,
      cl.DEPARTMENT_DESC,
      cl.ADDRESS_ID,
      cl.ADDRESS_DESC,
      cl.CITY_ID,
      cl.CITY_DESC,
      cl.COUNTRY_ID,
      cl.COUNTRY_DESC,
      cl.SUBREGION_ID,
      cl.SUBREGION_DESC,
      cl.REGION_ID,
      cl.REGION_DESC,
      cl.PHONE,
      cl.POSTAL_CODE,
      cl.START_DT,
      cl.END_DT,
      cl.IS_ACTIVE,
      sysdate,
      sysdate);
 COMMIT;
 END;

-- dim_Products
PROCEDURE DIM_PRODUCTS AS
BEGIN
MERGE INTO dim_products dim
USING (SELECT * FROM cls_products) cl
  ON (cl.product_id = dim.product_id AND
      cl.category_id = dim.category_id AND
      cl.localization_id = dim.localization_id)
    WHEN MATCHED 
      THEN UPDATE
        SET
          dim.PRODUCT_DESC = PRODUCT_DESC,
          dim.PRODUCT_PRICE = PRODUCT_PRICE,
          dim.CATEGORY_DESC = CATEGORY_DESC,
          dim.SUBCATEGORY_ID = SUBCATEGORY_ID,
          dim.SUBCATEGORY_DESC = SUBCATEGORY_DESC,
          dim.SUBCATEGORY_SIZE = SUBCATEGORY_SIZE,
          dim.SUBCATEGORY_TOBACCO = SUBCATEGORY_TOBACCO,
          dim.LOCALIZATION_DESC = LOCALIZATION_DESC,
          UPDATE_DT = sysdate
    WHEN NOT MATCHED
      THEN INSERT
        VALUES (
          seq_dproduct.nextval,
          cl.PRODUCT_ID,
          cl.PRODUCT_DESC,
          cl.PRODUCT_PRICE,
          cl.CATEGORY_ID,
          cl.CATEGORY_DESC,
          cl.SUBCATEGORY_ID,
          cl.SUBCATEGORY_DESC,
          cl.SUBCATEGORY_SIZE,
          cl.SUBCATEGORY_TOBACCO,
          cl.LOCALIZATION_ID,
          cl.LOCALIZATION_DESC,
          sysdate,
          sysdate);
COMMIT;
END;

-- dim_PROMOTIONS
PROCEDURE DIM_PROMOTIONS AS
BEGIN
MERGE INTO dim_promotions dim
USING (SELECT * FROM cls_promotions) cl
  ON (
    dim.PROMO_id = cl.promo_id
    )
  WHEN MATCHED
    THEN UPDATE
      SET
        dim.PROMO_NAME = cl.PROMO_NAME,
        dim.PROMO_DESC = dim.PROMO_DESC,
        dim.PROMO_COST = dim.PROMO_COST,
        dim.START_DT = dim.START_DT,
        dim.END_DT = dim.END_DT,
        dim.IS_ACTIVE = dim.IS_ACTIVE,
        dim.UPDATE_DT = sysdate
  WHEN NOT MATCHED
    THEN INSERT 
      VALUES (
          seq_dpromotion.nextval,
          cl.PROMO_ID,
          cl.PROMO_NAME,
          cl.PROMO_DESC,
          cl.PROMO_COST,
          cl.START_DT,
          cl.END_DT,
          cl.IS_ACTIVE,
          sysdate,
          sysdate
        );
COMMIT;
END;

-- dim_DATE
PROCEDURE DIM_DATE AS
BEGIN
MERGE INTO dim_date dim
  USING (SELECT * FROM cls_date) cl 
  ON ( TRUNC(dim.date_id) = TRUNC(cl.date_id))
    WHEN MATCHED
      THEN UPDATE 
        SET 
          dim.DAY_WEEK	=	cl.DAY_WEEK		,
          dim.DAY_SHORT	=	cl.DAY_SHORT		,
          dim.DAY_LONG	=	cl.DAY_LONG		,
          dim.DAY_MONTH	=	cl.DAY_MONTH		,
          dim.LASTDAY_MONTH	=	cl.LASTDAY_MONTH		,
          dim.DAY_YEAR	=	cl.DAY_YEAR		,
          dim.MONTH_YEAR	=	cl.MONTH_YEAR		,
          dim.MONTH_SHORT	=	cl.MONTH_SHORT		,
          dim.MONTH_LONG	=	cl.MONTH_LONG		,
          dim.MONTH_DESC	=	cl.MONTH_DESC		,
          dim.QUARTER	=	cl.QUARTER		,
          dim.YEAR_HALF	=	cl.YEAR_HALF		,
          dim.YEAR	=	cl.YEAR		
    WHEN NOT MATCHED
      THEN INSERT 
        VALUES (
          (cl.DATE_ID),
          cl.DAY_WEEK	,
          cl.DAY_SHORT	,
          cl.DAY_LONG	,
          cl.DAY_MONTH	,
          cl.LASTDAY_MONTH	,
          cl.DAY_YEAR	,
          cl.MONTH_YEAR	,
          cl.MONTH_SHORT	,
          cl.MONTH_LONG	,
          cl.MONTH_DESC	,
          cl.QUARTER	,
          cl.YEAR_HALF	,
          cl.YEAR	
        );
COMMIT;
END;

-- FCT_SALES
PROCEDURE FCT_SALES AS
BEGIN
MERGE INTO FCT_SALES fct
USING (SELECT * FROM CLS_SALES) cl
  ON (
    fct.PRODUCT_ID = cl.PRODUCT_ID AND 
    fct.DEPARTMENT_ID = cl.DEPARTMENT_ID AND
    fct.CONSUMER_ID = cl.CONSUMER_ID AND
    fct.PROMO_ID = cl.PROMO_ID AND
    TRUNC(fct.DATE_ID) = TRUNC(cl.DATE_ID)
    )
  WHEN MATCHED
    THEN UPDATE
      SET 
        fct.COST = cl.COST, 
        fct.AMOUNT = cl.AMOUNT,
        fct.UPDATE_DT = sysdate
  WHEN NOT MATCHED
    THEN INSERT
      VALUES (
        cl.PRODUCT_ID,
        cl.DEPARTMENT_ID,
        cl.CONSUMER_ID,
        cl.PROMO_ID,
        TRUNC(cl.DATE_ID),
        cl.COST,
        cl.AMOUNT,
        sysdate,
        sysdate);
COMMIT;
END;
END DWH_DDL;
/