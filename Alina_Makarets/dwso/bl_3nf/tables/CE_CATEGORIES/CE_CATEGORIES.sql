CREATE TABLE CE_CATEGORIES (
        "Category_srcid" NUMBER(4) NOT NULL,
        "Category_name" VARCHAR2(40),
        "Category_desc" VARCHAR2(80),
         CONSTRAINT "PK_Category_id"
            PRIMARY KEY ("Category_srcid")
          );