-- CLS_PRODUCT_CATEGORY
execute pkg_drop.DROP_proc('cls_PRODUCT_CATEGORY','table');   
CREATE TABLE CLS_PRODUCT_CATEGORY
(
  "CATEGORY_CODE" VARCHAR2(50),
  "CATEGORY_NAME" VARCHAR2(50),
  "UPDATE_DT" DATE,
  "INSERT_DT" DATE
)
;