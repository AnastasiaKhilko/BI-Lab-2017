

 CREATE
  TABLE BL_3NF_Province
  (
    province_id number(4) primary key,
    Province   VARCHAR2 (100) 
  );
  TRUNCATE TABLE BL_3NF_Province;
  CREATE sequence  BL_3NF_Province_seq start with 1 increment BY 1 nocache nocycle;
  
CREATE
  TABLE  BL_3NF_REGION
  (
  region_id number(4) primary key,
    region_name VARCHAR2 (200),
    Province_ID number (4),
    CONSTRAINT fk_Province_ID
    FOREIGN KEY (Province_ID)
    REFERENCES BL_3NF_Province ( province_id)
  );
  
  CREATE sequence  BL_3NF_REGION_seq start with 1 increment BY 1 nocache nocycle;
  
   CREATE
  TABLE BL_3NF_Segment
  (
    Segment_id NUMBER(4) primary key,
    Segment_NAME   VARCHAR2 (20)
  );
  
CREATE sequence  BL_3NF_Segment_SEQ start with 1 increment BY 1 nocache nocycle;

CREATE
  TABLE BL_3NF_Ship_Mode
  (
   Ship_Modet_id NUMBER(4) primary key,
    Ship_Mode   VARCHAR2 (20)
  );
  
CREATE sequence  BL_3NF_Ship_Mode_SEQ start with 1 increment BY 1 nocache nocycle;

CREATE
  TABLE BL_3NF_Category
  (
   Category_id NUMBER(4) primary key ,
    Category_Name  VARCHAR2 (300)
  );
CREATE sequence  BL_3NF_Category_SEQ start with 1 increment BY 1 nocache nocycle;

  CREATE
  TABLE BL_3NF_Sub_Category
  (
    Sub_Category_id NUMBER(4) primary key,
    Subcategory_Name VARCHAR2 (300),
    Category_id      NUMBER(4),
    CONSTRAINT fk_Category_id
    FOREIGN KEY (Category_id)
    REFERENCES BL_3NF_Category (Category_id)
  );

 CREATE sequence  BL_3NF_Sub_Category_SEQ start with 1 increment BY 1 nocache nocycle;
 
  CREATE
  TABLE BL_3NF_Product
  (
   Product_id NUMBER(4) primary key,
    Product_Name   VARCHAR2 (900),
    Unit_Price     NUMBER (8, 2), 
   Sub_Category_id NUMBER(4) ,
     CONSTRAINT fk_Sub_Category_id
    FOREIGN KEY (Sub_Category_id)
    REFERENCES BL_3NF_Sub_Category (Sub_Category_id)
  );
   CREATE sequence  BL_3NF_Product_SEQ start with 1 increment BY 1 nocache nocycle;

 
  CREATE
  TABLE BL_3NF_Customer
  (
  CUSTOMER_ID NUMBER (4) primary key,
   CUSTOMER_FIRST_NAME  VARCHAR2 (100),
   CUSTOMER_lAST_NAME   VARCHAR2 (100),
   province_id number(4),
   CONSTRAINT fk_CUST_province_id
    FOREIGN KEY (province_id)
    REFERENCES BL_3NF_Province (province_id)
  );
   CREATE sequence  BL_3NF_Customer_SEQ start with 1 increment BY 1 nocache nocycle;

CREATE
  TABLE BL_3NF_Manager
  (
   Manager_ID NUMBER (4) primary key,
    REGION_id  NUMBER (4),
    Manager_LASTNAME  VARCHAR2 (20),
     CONSTRAINT fk_MANAG_REGION_id
    FOREIGN KEY (REGION_id)
    REFERENCES BL_3NF_REGION (REGION_id)
   
  );
   CREATE sequence  BL_3NF_Manager_SEQ start with 1 increment BY 1 nocache nocycle;

  CREATE
  TABLE BL_3NF_ORDER
  (
    ORDER_ID             NUMBER (4)PRIMARY KEY, 
    ORDER_BK             NUMBER (4), 
    ORDER_DATE           DATE,
    SHIP_MODE_ID         NUMBER (4),
    CUSTOMER_ID          NUMBER (4),
    CUSTOMER_SEGMENT_ID  NUMBER (4),
    Product_ID           NUMBER (4),
    PRODUCT_CONTAINER    VARCHAR2 (100  ),
    PRODUCT_BASE_MARGIN  NUMBER (2, 2), 
    Order_Priority       VARCHAR2 (100  ),
    Order_Quantity       NUMBER(8),
    SALES                NUMBER (8, 2),
    DISCOUNT             NUMBER (8, 2),
    PROFIT               NUMBER (8, 2), 
    SHIPPING_COST        NUMBER (8, 2),
    SHIP_DATE          DATE,
      CONSTRAINT fk_SHIP_MODE_ID
    FOREIGN KEY (SHIP_MODE_ID)
    REFERENCES BL_3NF_SHIP_MODE ( Ship_Modet_id ),
    
     CONSTRAINT fk_CUSTOMER_ID 
    FOREIGN KEY (CUSTOMER_ID )
    REFERENCES BL_3NF_CUSTOMER (CUSTOMER_ID ),
    
     CONSTRAINT fk_CUSTOMER_SEGMENT_ID
    FOREIGN KEY (CUSTOMER_SEGMENT_ID )
    REFERENCES BL_3NF_SEGMENT(Segment_id  ),
     
     CONSTRAINT fk_Product_ID  
    FOREIGN KEY (Product_ID )
    REFERENCES BL_3NF_Product (Product_id  )
  );
     CREATE sequence  BL_3NF_ORDER_SEQ start with 1 increment BY 1 nocache nocycle;

  CREATE
  TABLE BL_3NF_RETURNED_ORDERS
  (
        ORDER_ID NUMBER(10,0) PRIMARY KEY,
        STATUS varchar2 ( 100),
         CONSTRAINT fk_ORDER_ID  
    FOREIGN KEY (ORDER_ID )
    REFERENCES BL_3NF_ORDER (ORDER_ID  )
  );
  
  
COMMIT;
  
  
