
CREATE
  TABLE BL_CL_RETURNED_ORDERS
  (
        ORDER_ID NUMBER(10,0),
        STATUS varchar2 ( 100)
  );
  

CREATE
  TABLE BL_CL_REGION
  (
  region_name VARCHAR2 (200),
    Province_NAME VARCHAR2 (200)
  );

  CREATE
  TABLE BL_CL_Province
  (
    Province   VARCHAR2 (100)
  );

  CREATE
  TABLE BL_CL_Segment
  (
  
    Segment_NAME   VARCHAR2 (20)
  );
  

CREATE
  TABLE BL_CL_Ship_Mode
  (
    ShipMode   VARCHAR2 (20)
  );
  

CREATE
  TABLE BL_CL_Category
  (
    Category_Name  VARCHAR2 (300)
  );

  CREATE
  TABLE BL_CL_Sub_Category
  (
    
    Subcategory_Name VARCHAR2 (300),
    Category_NAME      VARCHAR2 (300)
  );

  
  CREATE
  TABLE BL_CL_Product
  (
    Product_Name   VARCHAR2 (900),
    Unit_Price     NUMBER (8, 2), 
    Sub_Category  VARCHAR2 (200)
  );
  
  
  CREATE
  TABLE BL_CL_ORDER
  (
    ORDER_ID NUMBER(5),
    ORDER_DATE           DATE,
    SHIP_MODE            VARCHAR2 (50),
    CUSTOMER_FIRST_NAME  VARCHAR2 (100),
    CUSTOMER_lAST_NAME   VARCHAR2 (100),
     CUSTOMER_SEGMENT    VARCHAR2 (300 ),
    Product_name         VARCHAR2 (900),
    PRODUCT_CONTAINER     VARCHAR2 (100  ),
    PRODUCT_BASE_MARGIN   NUMBER (2, 2), 
    Order_Priority       VARCHAR2 (50 ),
    Order_Quantity       NUMBER(8),
    SALES                NUMBER (8, 2),
    DISCOUNT             NUMBER (8, 2),
    PROFIT               NUMBER (8, 2), 
    SHIPPING_COST        NUMBER (8, 2),
      SHIP_DATE          DATE
  );
  

  
  
CREATE
  TABLE BL_CL_Customer
  (
   CUSTOMER_FIRST_NAME  VARCHAR2 (100),
   CUSTOMER_lAST_NAME   VARCHAR2 (100),
   Province_NAME VARCHAR2 (30)
  );

CREATE
  TABLE BL_CL_Manager
  (
    REGION_NAME VARCHAR2 (30),
    Manager_LASTNAME  VARCHAR2 (20)
   
  );

DROP TABLE BL_CL_ORDER;
TRUNCATE TABLE BL_CL_ORDER;
COMMIT;
