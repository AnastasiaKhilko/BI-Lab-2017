DROP TABLE cls_sales;

CREATE TABLE cls_sales
    (   
        sales_number      NUMBER ( 38 )         ,
        event_dt          DATE                  ,
        product_id        NUMBER ( 10 )         ,
        employee_id       NUMBER ( 10 )         ,
        customer_id       NUMBER ( 10 )         ,
        shop_id           NUMBER ( 10 )         ,
        payment_method    VARCHAR2 ( 50 CHAR )  ,
        unit_amount       NUMBER ( 10 )         ,
        total_sum         NUMBER ( 38 )         
        );
        
        
 