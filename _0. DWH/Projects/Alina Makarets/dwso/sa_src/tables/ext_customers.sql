-- EXT_CUSTOMERS
DROP TABLE EXT_CUSTOMERS;

CREATE TABLE EXT_CUSTOMERS
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
         )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY external_customers_tables
                         ACCESS PARAMETERS (fields terminated BY ';')
                         LOCATION ('customers.csv',
                                   'customers1.csv',
                                   'customers2.csv',
                                   'customers3.csv',
                                   'customers4.csv',
                                   'customers5.csv',
                                   'customers6.csv',
                                   'customers7.csv',
                                   'customers8.csv',
                                   'customers9.csv',
                                   'customers10.csv',
                                   'customers11.csv',
                                   'customers12.csv',
                                   'customers13.csv',
                                   'customers14.csv',
                                   'customers15.csv',
                                   'customers16.csv',
                                   'customers17.csv',
                                   'customers18.csv',
                                   'customers19.csv',
                                   'customers20.csv',
                                   'customers21.csv',
                                   'customers22.csv',
                                   'customers23.csv',
                                   'customers24.csv',
                                   'customers25.csv',
                                   'customers26.csv',
                                   'customers27.csv',
                                   'customers28.csv',
                                   'customers29.csv',
                                   'customers30.csv',
                                   'customers31.csv')
    )
    REJECT LIMIT UNLIMITED;