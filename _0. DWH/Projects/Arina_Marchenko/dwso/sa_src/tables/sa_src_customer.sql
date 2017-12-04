drop table customer;
CREATE TABLE customer
        (customer_id     NUMBER ( 38 ),
         gender   VARCHAR2 ( 200 CHAR ),
         first_name   VARCHAR2 ( 200 CHAR ),
         last_name   VARCHAR2 ( 200 CHAR ),
         address  VARCHAR2 ( 200 CHAR ),
         city   VARCHAR2 ( 200 CHAR ),
         state VARCHAR2 ( 200 CHAR ),
        country  VARCHAR2 ( 200 CHAR ),
        email varchar2(200),
        phone varchar2(200),
        age varchar2(200)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL 
                (customer_id integer external (6),
                 gender char(200),
                 first_name char(200),
                 last_name   char(200),
                 address char(200),
                 city char(200),
                 state char(200),
                 country char(200),
                 email char(200),
                 phone char(200),
                 age char(200))
             )
         LOCATION ('cust.csv')
    )
    reject LIMIT unlimited;
    select count(*) from customer;
   commit;
  
  GRANT SELECT ON customer to bl_cl;
  