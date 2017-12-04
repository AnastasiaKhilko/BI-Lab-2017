    
  -- ext_managers
    create table WRK_MANAGERS
        (
        region varchar2 ( 100 char ),
        last_name varchar2 ( 100 )
         );
   
COMMIT;
     -- ext_ret_orders
     create table WRK_RET_ORDERS
        (
        ORDER_ID NUMBER(10,0),
        STATUS varchar2 ( 100)
         );
COMMIT;

    -- ext_orders
    CREATE TABLE WRK_ORDERS
      (
        ORDER_ID              NUMBER (10),
        ORDER_DATE            VARCHAR2 ( 15),
        ORDER_PRIORITY        VARCHAR2 ( 50 ),
        ORDER_QUANTITY        NUMBER (10),
        SALES                 NUMBER (8, 2),
        DISCOUNT              NUMBER (8, 2),
        SHIP_MODE             VARCHAR2 ( 50),
        PROFIT                NUMBER (8, 2), 
        UNIT_PRICE            NUMBER (8, 2), 
        SHIPPING_COST         NUMBER (8, 2), 
        CUSTOMER_NAME         VARCHAR2 (200),
        PROVINCE              VARCHAR2 (100 ),
        REGION                VARCHAR2 (200),
        CUSTOMER_SEGMENT      VARCHAR2 (300 ),
        PRODUCT_CATEGORY      VARCHAR2 (300),
        PRODUCT_SUB_CATEGORY  VARCHAR2 (600  ),
        PRODUCT_NAME          VARCHAR2 (900  ),
        PRODUCR_CONTAINER     VARCHAR2 (100  ),
        PRODUCT_BASE_MARGIN   NUMBER (2, 2), 
        SHIP_DATE             VARCHAR2 ( 50 )
      );
    COMMIT;
