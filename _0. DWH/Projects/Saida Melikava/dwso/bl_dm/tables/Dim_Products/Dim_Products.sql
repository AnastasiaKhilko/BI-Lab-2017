DROP TABLE Dim_Products;
CREATE TABLE Dim_Products
  (
    Product_id            NUMBER(8) PRIMARY KEY,
    Product_code          VARCHAR2(25) NOT NULL,
    Product_Category_name VARCHAR2(35) NOT NULL,
    Category_description  VARCHAR2(150) NOT NULL,
    Product_name          VARCHAR2(150) NOT NULL,
    Product_description   VARCHAR2(150) NOT NULL,
    Product_genre         VARCHAR2(65) NOT NULL,
    Product_author        VARCHAR2(65) NOT NULL,
    Product_weight_kg     NUMBER(3,3) NOT NULL,
    Product_weight_MB     NUMBER(5,3) NOT NULL,
    Product_symb_num      NUMBER(8) NOT NULL,
    Product_durability    NUMBER(8) NOT NULL,
    Product_reader        VARCHAR2(65) NOT NULL,
    Insert_DT             DATE NOT NULL,
    Update_DT             DATE NOT NULL
  );
COMMENT ON TABLE Dim_Products
IS
  'Table Content: All information about products.   
Refresh Cycle/Window: Data is loaded often and for a long period of time.  
';
  COMMENT ON column Dim_Products.Product_id
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
  COMMENT ON column Dim_Products.Product_weight_MB
IS
  'Weight in MB for e-books';
  COMMENT ON column Dim_Products.Product_symb_num
IS
  'Number of symbols for e-book';
  COMMENT ON column Dim_Products.Product_durability
IS
  'Durability in minutes for audiobooks';
  COMMENT ON column Dim_Products.Product_reader
IS
  'Reader. For audiobooks';
  COMMENT ON column Dim_Products.Insert_DT
IS
  'When data was loaded';
  COMMENT ON column Dim_Products.Update_DT
IS
  'When data was updated';
  /*
  GRANT SELECT ON dim_template TO some_user;*/
