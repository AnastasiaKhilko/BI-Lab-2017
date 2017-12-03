DROP TABLE Dim_Cl_Products CASCADE CONSTRAINTS;
CREATE TABLE Dim_Cl_Products
  (
    Product_3nf_id        NUMBER(8) ,
    Product_code          VARCHAR2(50) ,
    Product_category_name VARCHAR2(56) ,
    Product_name          VARCHAR2(150) ,
    Product_author_id     NUMBER(8) ,
    Product_author        VARCHAR2(160) ,
    Product_description   VARCHAR2(500) ,
    Product_genre_id      NUMBER(8) ,
    Product_genre         VARCHAR2(80) ,
    Product_weight_kg     NUMBER(8,5) 
  );
