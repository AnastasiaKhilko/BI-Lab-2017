CREATE TABLE DIM_PRODUCTS (
        "Product_id" NUMBER(10) NOT NULL,
        "Product_name" VARCHAR2(40) NOT NULL,
        "Product_code" VARCHAR2(10) NOT NULL,
        "Color_name" VARCHAR2(40) NOT NULL,
        "Color_id" NUMBER(4) NOT NULL,
        "Category_name" VARCHAR2(40) NOT NULL,
        "Category_id" NUMBER(4) NOT NULL,
        "Collection_name" VARCHAR2(40) NOT NULL,
        "Collection_id" NUMBER(4) NOT NULL,
        "Price" NUMBER(10) NOT NULL,
        "Insert_dt" DATE NOT NULL,
        "Start_dt" DATE NOT NULL,
        "End_dt" DATE NOT NULL,
        "Is_active" VARCHAR2(4) NOT NULL,
        CONSTRAINT "PK_Product_id"
          PRIMARY KEY ("Product_id"),
        CONSTRAINT "FK_Color_id"
          FOREIGN KEY ("Color_id")
            REFERENCES DIM_COLORS("Color_id") ,
        CONSTRAINT "FK_Category_id"
          FOREIGN KEY ("Category_id")
            REFERENCES DIM_CATEGORIES("Category_id"),
        CONSTRAINT "FK_Collection_id"
          FOREIGN KEY ("Collection_id")
            REFERENCES DIM_COLLECTIONS("Collection_id")
         );
