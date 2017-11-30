-- WRK_PRODUCTS.
DROP TABLE WRK_PRODUCTS;

CREATE TABLE WRK_PRODUCTS
  (
    category_name       VARCHAR2 ( 200 CHAR ),
    subcategory_name    VARCHAR2 ( 200 CHAR ),
    product_name        VARCHAR2 ( 200 CHAR ),
    product_desc        VARCHAR2 ( 300 CHAR ),
    product_code        VARCHAR2 ( 300 CHAR ),
    color               NUMBER ( 30 ),
    color_name          VARCHAR2 ( 300 CHAR ),
    collection_name     VARCHAR2 ( 300 CHAR ),
    price               VARCHAR2 ( 20 CHAR ),
    start_date          VARCHAR2 ( 100 CHAR )
  );