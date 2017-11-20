DROP TABLE DIM_CATEGORIES;
CREATE TABLE DIM_CATEGORIES (
        "Category_id"   NUMBER(4)    NOT NULL,
        "Category_name" VARCHAR2(40) NOT NULL,
        "Category_desc" VARCHAR2(80) NOT NULL,
        "Insert_dt"     DATE         NOT NULL,
        "Update_dt"     DATE         NOT NULL,
        CONSTRAINT "PK_Category_id"
          PRIMARY KEY ("Category_id")
          );