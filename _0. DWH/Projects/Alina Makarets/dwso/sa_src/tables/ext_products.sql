-- EXT_PRODUCTS.
DROP TABLE EXT_PRODUCTS;

CREATE TABLE EXT_PRODUCTS
  (
    category_name       VARCHAR2 ( 200 CHAR ),
    subcategory_name    VARCHAR2 ( 200 CHAR ),
    product_name        VARCHAR2 ( 200 CHAR ),
    product_desc        VARCHAR2 ( 300 CHAR ),
    product_code        VARCHAR2 ( 300 CHAR ),
    color               NUMBER ( 30 ),
    color_name          VARCHAR2 ( 300 CHAR ),
    collection_name     VARCHAR2 ( 300 CHAR ),
    price               VARCHAR2 ( 100 CHAR ),
    start_date          VARCHAR2 ( 100 CHAR )
  )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY external_products_tables
                         ACCESS PARAMETERS (fields terminated BY ';')
                         LOCATION ('products.csv')
    )
    REJECT LIMIT UNLIMITED;