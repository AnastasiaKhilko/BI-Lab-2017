DROP TABLE PRODUCTS;

CREATE TABLE PRODUCTS (
        "Product_id" NUMBER(10) NOT NULL,
        "Product_name" VARCHAR2(40),
        "Product_code" VARCHAR2(10),
        "Color_name" VARCHAR2(40),
        "Color_id" NUMBER(4),
        "Category_name" VARCHAR2(40),
        "Category_id" NUMBER(4),
        "Collection_name" VARCHAR2(40),
        "Collection_id" NUMBER(4),
        "Price" NUMBER(10)
         );
        
ALTER TABLE PRODUCTS 
    ADD CONSTRAINT "PK_Product_id"
    PRIMARY KEY ("Product_id");
    
ALTER TABLE PRODUCTS 
    ADD CONSTRAINT "FK_Color_id"
    FOREIGN KEY ("Color_id")
        REFERENCES COLORS("Color_id");
      
ALTER TABLE PRODUCTS 
    ADD CONSTRAINT "FK_Category_id"
    FOREIGN KEY ("Category_id")
        REFERENCES CATEGORIES("Category_id"); 
        
ALTER TABLE PRODUCTS 
    ADD CONSTRAINT "FK_Collection_id"
    FOREIGN KEY ("Collection_id")
        REFERENCES COLLECTIONS("Collection_id"); 