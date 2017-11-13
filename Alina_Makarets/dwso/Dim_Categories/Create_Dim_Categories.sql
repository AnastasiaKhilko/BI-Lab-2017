DROP TABLE CATEGORIES;

CREATE TABLE CATEGORIES (
        "Category_id" NUMBER(4) NOT NULL,
        "Category_name" VARCHAR2(40),
        "Category_desñ" VARCHAR2(80)
          );
        
ALTER TABLE CATEGORIES 
    ADD CONSTRAINT "PK_Category_id"
    PRIMARY KEY ("Category_id");