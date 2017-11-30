DROP TABLE cls_fct_sales;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE cls_fct_sales
    (
        sales_id          NUMBER ( 10 )        NOT NULL  ,
        event_dt          DATE                 NOT NULL  ,
        product_id        NUMBER ( 10 )        NOT NULL  ,
        employee_id       NUMBER ( 10 )        NOT NULL  ,
        customer_id       NUMBER ( 10 )        NOT NULL  ,
        shop_id           NUMBER ( 10 )        NOT NULL  ,
        payment_method    VARCHAR2 ( 50 CHAR ) NOT NULL  ,
        unit_amount       NUMBER ( 10 )        NOT NULL  ,
        total_sum         NUMBER ( 38 )        NOT NULL   
        );
        
        
 