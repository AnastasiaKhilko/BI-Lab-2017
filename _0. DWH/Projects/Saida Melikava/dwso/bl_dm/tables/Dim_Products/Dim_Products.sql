DROP TABLE Dim_Products CASCADE CONSTRAINTS;
CREATE TABLE Dim_Products
  (
    Product_sur_id        NUMBER(8) PRIMARY KEY,
    Product_3nf_id        NUMBER(8) NOT NULL,
    Product_code          VARCHAR2(25) NOT NULL,
    Product_category_name VARCHAR2(70) NOT NULL,
    Product_name          VARCHAR2(150) NOT NULL,
    Product_author_id     NUMBER(8) NOT NULL,
    Product_author        VARCHAR2(160) NOT NULL,
    Product_description   VARCHAR2(500) NOT NULL,
    Product_genre_id      NUMBER(8) NOT NULL,
    Product_genre         VARCHAR2(65) NOT NULL,
    Product_weight_kg     NUMBER(8,5) NOT NULL,
    insert_DT             DATE DEFAULT(sysdate) NOT NULL ,
    update_DT             DATE DEFAULT(sysdate) NOT NULL
  );
COMMENT ON TABLE Dim_Products
IS
  'Table Content: All information about products.   
Refresh Cycle/Window: Data is loaded often and for a long period of time.  
';
  COMMENT ON column Dim_Products.Product_sur_id
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Products.Product_code
IS
  'Dimension business key, comes from external system.';
  COMMENT ON column Dim_Products.Product_Category_name
IS
  'Dimension surrogate keyPrinted book, e-book, audiobook';
  COMMENT ON column Dim_Products.Product_weight_kg
IS
  'Weight in kg for printed books';
  COMMENT ON column Dim_Products.Insert_DT
IS
  'When data was loaded';
  COMMENT ON column Dim_Products.Update_DT
IS
  'When data was updated'; 