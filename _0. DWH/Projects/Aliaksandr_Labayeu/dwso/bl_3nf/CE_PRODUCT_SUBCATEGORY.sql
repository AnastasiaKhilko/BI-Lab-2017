-- CE_PRODUCT_SUBCATEGORY
execute pkg_drop.DROP_proc('"BL_3NF"."CE_PRODUCT_SUBCATEGORY"','table');
CREATE TABLE "BL_3NF"."CE_PRODUCT_SUBCATEGORY"
(
	"SUBCATEGORY_ID" NUMBER(8,2) NOT NULL,
	"SUBCATEGORY_CODE" VARCHAR2(50),
	"SUBCATEGORY_NAME" VARCHAR2(50),
	"CATEGORY_ID" NUMBER(8,2),
	"SIZE" NUMBER(3),
	"TOBACCO" NUMBER(3,1),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
)
;

execute pkg_drop.DROP_proc('seq_product_subcategory','sequence');
CREATE SEQUENCE seq_product_subcategory
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;  