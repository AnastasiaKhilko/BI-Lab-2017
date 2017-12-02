DROP TABLE cls_products;


CREATE TABLE cls_products
    (
        product_id      VARCHAR2 ( 100 )      ,
        product_name    VARCHAR2 ( 200 CHAR ) ,
        product_desc    VARCHAR2 ( 300 CHAR ) ,
        price           NUMBER ( 20,2 )       ,
        color_id        NUMBER ( 10 )         ,
        collection_id   NUMBER ( 10 )         ,
        category_id     NUMBER ( 10 )         ,
        subcategory_id  NUMBER ( 10 )         ,
        start_dt        DATE                  ,
        end_dt          DATE                  ,
        is_active       VARCHAR2 ( 4 )      
        );

 