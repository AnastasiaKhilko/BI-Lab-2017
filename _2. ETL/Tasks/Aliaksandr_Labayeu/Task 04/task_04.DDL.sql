  execute pkg_drop.DROP_proc('seq_product_category','sequence');
  CREATE SEQUENCE seq_product_category
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;

execute pkg_drop.DROP_proc('cls_PRODUCT_CATEGORY','table');         
CREATE TABLE cls_PRODUCT_CATEGORY
(
	"CATEGORY_ID" VARCHAR2(10) NOT NULL,
	"CATEGORY_NAME" VARCHAR2(50)
)
;

  execute pkg_drop.DROP_proc('seq_product_subcategory','sequence');
  CREATE SEQUENCE seq_product_subcategory
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;

execute pkg_drop.DROP_proc('cls_PRODUCT_SUBCATEGORY','table');           
CREATE TABLE cls_PRODUCT_SUBCATEGORY
(
	"SUBCATEGORY_ID" VARCHAR2(10) NOT NULL,
	"SUBCATEGORY_NAME" VARCHAR2(50),
	"CATEGORY_ID" NUMBER(8,2)
)
;