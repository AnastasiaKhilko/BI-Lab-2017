------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Generate fact table.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_fact_dim
as
  PROCEDURE insert_bl_dim;
END pckg_insert_fact_dim;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_fact_dim
AS

PROCEDURE insert_bl_dim
IS
BEGIN

  INSERT /*+ PARALLEL(BL_3NF.CE_FCT_SALES) */
  INTO bl_dm.fct_sales
    (
      EVENT_DT,
  FCT_CUSTOMER_ID,
  FCT_EMPLOYEE_ID,
  FCT_STORE_ID,
  FCT_STORE_DIST_ID,
  FCT_PRODUCT_ID,
  FCT_PAYMENT_ID,
  FCT_CHECK_ID,
  FCT_QUANTITY,
  FCT_DISCOUNT,
  FCT_UNIT_PRICE_BYN,
  FCT_UNIT_PRICE_DISC_BYN,
  FCT_SALES_AMOUNT_BYN,
  FCT_BYN_USD,
  FCT_UNIT_PRICE_USD,
  FCT_UNIT_PRICE_DISC_USD,
  FCT_SALES_AMOUNT_USD
    )
SELECT /*+ PARALLEL(4) */
to_date(EVENT_DT, 'dd-mm-yyyy'),
  FCT_CUSTOMER_ID,
  FCT_EMPLOYEE_ID,
  FCT_STORE_ID,
  FCT_STORE_DIST_ID,
  FCT_PRODUCT_ID,
  FCT_PAYMENT_ID,
  FCT_CHECK_ID,
  FCT_QUANTITY,
  FCT_DISCOUNT,
  FCT_UNIT_PRICE_BYN,
  FCT_UNIT_PRICE_DISC_BYN,
  FCT_SALES_AMOUNT_BYN,
  FCT_BYN_USD,
  FCT_UNIT_PRICE_USD,
  FCT_UNIT_PRICE_DISC_USD,
  FCT_SALES_AMOUNT_USD
FROM BL_3NF.CE_FCT_SALES ;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;

END pckg_insert_fact_dim;
/

