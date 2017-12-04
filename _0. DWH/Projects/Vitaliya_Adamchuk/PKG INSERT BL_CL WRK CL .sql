CREATE OR REPLACE PACKAGE  CL_INSERT_PKG AS 
--  PROCEDURE CL_MANAGER_INSERT (EXT_TABLE_NAME IN VARCHAR2, WRK_TABLE_NAME IN VARCHAR2);
  PROCEDURE CL_INSERT;
   END;
  / 
  
  CREATE OR REPLACE PACKAGE body  CL_INSERT_PKG AS  
   PROCEDURE CL_INSERT  AS
   BEGIN
   INSERT INTO BL_CL_Customer 
   SELECT DISTINCT substr(CUSTOMER_NAME,1, instr(CUSTOMER_NAME, ' ') - 1) ,
                    substr(CUSTOMER_NAME,instr(CUSTOMER_NAME,' ') + 1) , 
                    PROVINCE   FROM  WRK_ORDERS;
  INSERT INTO BL_CL_Segment SELECT DISTINCT  CUSTOMER_SEGMENT  FROM  WRK_ORDERS;
  INSERT INTO BL_CL_Segment SELECT DISTINCT  CUSTOMER_SEGMENT  FROM  WRK_ORDERS;
  INSERT INTO BL_CL_Ship_Mode SELECT DISTINCT SHIP_MODE FROM  WRK_ORDERS ;
  INSERT INTO BL_CL_PRODUCT SELECT DISTINCT PRODUCT_NAME, UNIT_PRICE, PRODUCT_SUB_CATEGORY FROM  WRK_ORDERS;
  INSERT INTO BL_CL_Sub_Category SELECT DISTINCT PRODUCT_SUB_CATEGORY, PRODUCT_CATEGORY FROM  WRK_ORDERS ;
  INSERT INTO BL_CL_Category SELECT DISTINCT PRODUCT_CATEGORY FROM  WRK_ORDERS;
  INSERT INTO BL_CL_Province SELECT DISTINCT PROVINCE FROM  WRK_ORDERS;
  INSERT INTO BL_CL_region SELECT DISTINCT  PROVINCE,REGION   FROM  WRK_ORDERS;
  INSERT INTO BL_CL_RETURNED_ORDERS SELECT * FROM  WRK_RET_ORDERS;
  INSERT INTO BL_CL_Manager SELECT * FROM  WRK_MANAGERS;
  INSERT INTO BL_CL_ORDER SELECT ORDER_ID ,
  to_date(ORDER_DATE, 'MM.DD.YYYY'),
                                SHIP_MODE, 
                                substr(CUSTOMER_NAME,1, instr(CUSTOMER_NAME, ' ') - 1) ,
                                substr(CUSTOMER_NAME,instr(CUSTOMER_NAME,' ') + 1) , 
                                CUSTOMER_SEGMENT,
                                Product_name ,
                                PRODUCR_CONTAINER ,
                                PRODUCT_BASE_MARGIN , 
                                Order_Priority,
                                Order_Quantity ,
                                SALES,
                                DISCOUNT,
                                PROFIT, 
                                SHIPPING_COST,
                                to_date(SHIP_DATE, 'MM.DD.YYYY')
                                FROM  WRK_ORDERS;
   END;
   
   END CL_INSERT_PKG;
  / 
 
    
  
 commit;
  
  EXECUTE CL_INSERT_PKG.CL_MANAGER_INSERT ('WRK_MANAGERS','BL_CL_Manager' );
  
  