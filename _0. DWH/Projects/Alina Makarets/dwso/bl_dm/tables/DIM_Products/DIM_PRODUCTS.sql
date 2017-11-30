DROP TABLE dim_products CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE dim_products
    (
        product_id          NUMBER ( 10 )         NOT NULL,
        product_surr_id     NUMBER ( 10 )         NOT NULL,
        product_name        VARCHAR2 ( 200 CHAR ) NOT NULL,
        product_desc        VARCHAR2 ( 300 CHAR ) NOT NULL,
        price               NUMBER ( 20 )         NOT NULL,        
        color_id            NUMBER ( 10 )         NOT NULL,
        color_name          VARCHAR2 ( 200 CHAR ) NOT NULL,
        collection_id       NUMBER ( 10 )         NOT NULL,
        collection_name     VARCHAR2 ( 200 CHAR ) NOT NULL,
        category_id         NUMBER ( 10 )         NOT NULL,
        category_name       VARCHAR2 ( 200 CHAR ) NOT NULL,
        subcategory_id      NUMBER ( 10 )         NOT NULL,
        subcategory_name    VARCHAR2 ( 200 CHAR ) NOT NULL,
        start_dt        DATE     DEFAULT '01-���-1990',
        end_dt          DATE     DEFAULT '31-���-9999',
        is_active       VARCHAR2 ( 10 )       NOT NULL,
        
        CONSTRAINT PK_product_id_dm       PRIMARY KEY ( product_id )   
        );
        
        
 