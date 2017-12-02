DROP TABLE cls_employees;

CREATE TABLE cls_employees
    (
        employee_id       NUMBER   ( 10 )       ,
        last_name         VARCHAR2 ( 100 CHAR ) ,
        first_name        VARCHAR2 ( 100 CHAR ) ,
        middle_name       VARCHAR2 ( 100 CHAR ) ,
        phone             VARCHAR2 ( 50 CHAR )  ,
        email             VARCHAR2 (150 CHAR )  ,
        age               NUMBER   ( 10 )       ,
        gender            VARCHAR2 ( 50 CHAR )  ,
        passport          VARCHAR2 ( 100 CHAR ) ,
        start_dt          DATE,
        end_dt            DATE,
        is_active         VARCHAR2 ( 10 CHAR )
        );
        
        
 