CREATE TABLE CE_PRODUCTS (
        "Product_srcid" NUMBER(10) NOT NULL,
        "Product_name" VARCHAR2(40),
        "Product_code" VARCHAR2(10),
        "Color_srcid" NUMBER(4),
        "Category_srcid" NUMBER(4),
        "Collection_srcid" NUMBER(4),
        "Price" NUMBER(10),
        CONSTRAINT "PK_Product_srcid"
          PRIMARY KEY ("Product_srcid"),
        CONSTRAINT "FK_Color_srcid"
         FOREIGN KEY ("Color_srcid")
            REFERENCES CE_COLORS("Color_srcid"),
        CONSTRAINT "FK_Category_srcid"
         FOREIGN KEY ("Category_srcid")
            REFERENCES CE_CATEGORIES("Category_srcid"),
       CONSTRAINT "FK_Collection_srcid"
         FOREIGN KEY ("Collection_srcid")
             REFERENCES CE_COLLECTIONS("Collection_srcid") 
        );
