DROP TABLE cls_customers;

CREATE TABLE cls_customers
    (
        customer_id  VARCHAR2 ( 100 CHAR ) ,
        last_name         VARCHAR2 ( 100 CHAR ) ,
        first_name        VARCHAR2 ( 100 CHAR ) ,
        middle_name       VARCHAR2 ( 100 CHAR ) ,
        phone             VARCHAR2 ( 50 CHAR )  ,
        email             VARCHAR2 (150 CHAR )  ,
        age               NUMBER   ( 10 )       ,
        discount          NUMBER   ( 10 )       ,
        gender            VARCHAR2 ( 50 CHAR )  ,
        city_id           NUMBER   ( 10 )       
        );
        
        
 