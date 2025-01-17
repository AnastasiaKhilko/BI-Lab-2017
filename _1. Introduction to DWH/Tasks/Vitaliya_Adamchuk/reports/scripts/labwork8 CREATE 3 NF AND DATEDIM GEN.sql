CREATE
  TABLE OrderDim
  (
    OrderID       NUMBER PRIMARY KEY,
    DateId       VARCHAR2 (8),
    ShipModeID    NUMBER,
    CustomerId    NUMBER,
    ProductID     NUMBER,
    OrderPriority VARCHAR2 (10),
    OrderQuantity NUMBER,
    Sales         NUMBER,
    Discount      NUMBER ,
    Profit        NUMBER,
    ShipimgCost   NUMBER
  );
CREATE
  TABLE CustomerDim
  (
    CustomerId        NUMBER PRIMARY KEY,
    CustomerFIRSTNAME VARCHAR2 (20),
    CustomerLASTNAME  VARCHAR2 (20),
    RegionID          NUMBER
  );
CREATE
  TABLE ManagerDim
  (
    ManagerId        NUMBER PRIMARY KEY,
    ManagerFIRSTNAME VARCHAR2 (20),
    ManagerLASTNAME  VARCHAR2 (20),
    RegionID         NUMBER
  );
CREATE
  TABLE ProductDim
  (
    ProductId     NUMBER PRIMARY KEY,
    ProductName   VARCHAR2 (50),
    UnitPrice     NUMBER,
    SubCategoryID NUMBER
  );
CREATE
  TABLE SubCategoryDim
  (
    SubcategoryId   NUMBER PRIMARY KEY,
    SubcategoryName VARCHAR2 (50),
    CategoryID      NUMBER
  );
CREATE
  TABLE CategoryDim
  (
    CategoryID   NUMBER,
    CategoryName VARCHAR2 (50)
  );
CREATE
  TABLE ShipModeDim
  (
    ShipModeID NUMBER,
    ShipMode   VARCHAR2 (20)
  );
CREATE
  TABLE SegmentDim
  (
    SegmentID NUMBER PRIMARY KEY,
    Segment   VARCHAR2 (20)
  );
CREATE
  TABLE ProvinceDim
  (
    ProvinceID NUMBER PRIMARY KEY,
    Province   VARCHAR2 (20)
  );
CREATE
  TABLE RegionDim
  (
    RegionID   NUMBER PRIMARY KEY,
    ProvinceID NUMBER,
    RegionName VARCHAR2 (20)
  );
CREATE
  TABLE ReturnDim
  (
    ReturnID NUMBER PRIMARY KEY,
    OrderID  NUMBER
  );
CREATE
  TABLE DateDim AS
SELECT
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY')    + NUMTODSINTERVAL(n,'day'),'YYYY')
  || TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM'
  )
  || TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD'
  )                                                             AS Date_Key,
  TO_DATE('31/12/2008','DD/MM/YYYY')         + NUMTODSINTERVAL(n,'day') AS Full_Date ,
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD')
  AS Day_Of_Momth,
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DDD')
  AS DAY_OF_YEAR ,
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DAY')
  AS day_of_week_full ,
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DY')
  AS day_of_week_short ,
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Mon')
  AS Month_Short,
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')
  AS Month_Num,
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Month'
  ) AS Month_Long,
  'Q'
  || TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Q')
  AS Quarter ,
  TO_CHAR(TO_DATE('31/12/2008','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY')
  AS YEAR
FROM
  (
    SELECT
      level n
    FROM
      dual
      CONNECT BY level <= 6760
  );

ALTER TABLE ORDERDIM ADD FOREIGN KEY (DATEID) REFERENCES DATEDIM (DATE_KEY);
ALTER TABLE SHIPMODEDIM ADD PRIMARY KEY (SHIPMODEID);
ALTER TABLE ORDERDIM ADD FOREIGN KEY (SHIPMODEID) REFERENCES SHIPMODEDIM (
SHIPMODEID);
ALTER TABLE CATEGORYDIM ADD PRIMARY KEY (CATEGORYID);
ALTER TABLE CUSTOMERDIM ADD PRIMARY KEY (CustomerId);
ALTER TABLE ORDERDIM ADD FOREIGN KEY (CustomerId) REFERENCES CUSTOMERDIM (
CustomerId);
ALTER TABLE ORDERDIM ADD FOREIGN KEY (ProductID ) REFERENCES ProductDIM (
ProductID );
ALTER TABLE ORDERDIM ADD FOREIGN KEY (ProductID ) REFERENCES ProductDIM (
ProductID );
ALTER TABLE ProductDIM ADD FOREIGN KEY (SUBCATEGORYID ) REFERENCES
SUBCATEGORYDIM (SUBCATEGORYID );
ALTER TABLE SUBCATEGORYDIM ADD FOREIGN KEY (CATEGORYID ) REFERENCES CATEGORYDIM
(CATEGORYID ); 
ALTER TABLE CUSTOMERDIM ADD FOREIGN KEY (REGIONID ) REFERENCES REGIONDIM
(REGIONID ); 
ALTER TABLE REGIONDIM ADD FOREIGN KEY (PROVINCEID ) REFERENCES PROVINCEDIM
(PROVINCEID ); 
ALTER TABLE REGIONDIM ADD FOREIGN KEY (PROVINCEID ) REFERENCES PROVINCEDIM
(PROVINCEID ); 
ALTER TABLE ORDERDIM ADD  MANAGERID NUMBER ; 
ALTER TABLE ORDERDIM ADD FOREIGN KEY (MANAGERID ) REFERENCES  MANAGERDIM
(MANAGERID ); 
ALTER TABLE RETURNDIM ADD FOREIGN KEY (ORDERID ) REFERENCES  ORDERDIM
(ORDERID ); 
ALTER TABLE ORDERDIM ADD  SEGMENTID NUMBER ; 
ALTER TABLE ORDERDIM ADD FOREIGN KEY (SEGMENTID ) REFERENCES  SEGMENTDIM
(SEGMENTID ); 
