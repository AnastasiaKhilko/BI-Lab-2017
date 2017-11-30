--WRK_CUSTOMERS
DROP TABLE wrk_customers;

CREATE TABLE wrk_customers
        (
         last_name    VARCHAR2 ( 200 CHAR ),
         first_name   VARCHAR2 ( 200 CHAR ),
         middle_name  VARCHAR2 ( 200 CHAR ),
         phone        VARCHAR2 ( 200 CHAR ),
         email        VARCHAR2 ( 200 CHAR ),
         age          NUMBER   ( 30 ),
         discount     NUMBER   ( 30 ),
         gender       NUMBER   ( 5) ,
         passport     VARCHAR2 ( 200 CHAR),
         city         VARCHAR2 ( 200 CHAR ),
         region       VARCHAR2 ( 200 CHAR)         
         );