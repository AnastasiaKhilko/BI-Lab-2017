CREATE TABLE DimProduct
  (
    Product_key          NUMBER(8) PRIMARY KEY,
    Product_id           VARCHAR2(25) NOT NULL,
    Category_name        VARCHAR2(35) NOT NULL,
    Category_description VARCHAR2(150) NOT NULL,
    Product_name         VARCHAR2(150) NOT NULL,
    Product_description  VARCHAR2(150) NOT NULL,
    Product_genre        VARCHAR2(65) NOT NULL,
    Product_author       VARCHAR2(65) NOT NULL,
    Product_weight_kg    NUMBER(3,3) NOT NULL,
    Product_weight_MB    NUMBER(5,3) NOT NULL,
    Product_symb_num     NUMBER(8) NOT NULL,
    Product_durability   NUMBER(8) NOT NULL,
    Product_reader       VARCHAR2(65) NOT NULL
  );
