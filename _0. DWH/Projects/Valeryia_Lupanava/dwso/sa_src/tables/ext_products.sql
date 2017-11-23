-- EXT_PRODUCTS.
CREATE TABLE ext_products
  (
    product_id      VARCHAR2 ( 300 CHAR ),
    product_name    VARCHAR2 ( 300 BYTE ),
    line_name       VARCHAR2 ( 300 CHAR ),
    collection_name VARCHAR2 ( 300 CHAR ),
    product_type    VARCHAR2 ( 300 CHAR ),
    color           VARCHAR2 ( 300 CHAR ),
    panty_size_id   VARCHAR2 ( 300 CHAR ),
    price           VARCHAR2 ( 300 CHAR ),
    balance         VARCHAR2 ( 300 CHAR )
  )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY external_prod_tables
                         ACCESS PARAMETERS (fields terminated BY ',')
                         LOCATION ('products_1.csv', 'products_2.csv',
                                   'products_3.csv', 'products_4.csv',
                                   'products_5.csv', 'products_6.csv')
    )
    REJECT LIMIT UNLIMITED;