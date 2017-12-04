drop table seller;
CREATE TABLE seller
        (seller_id     NUMBER ( 10 ),
         name   VARCHAR2 ( 200 CHAR ),
         surname   VARCHAR2 ( 200 CHAR ),
         address  VARCHAR2 ( 200 CHAR ),
         city   VARCHAR2 ( 200 CHAR ),
         state VARCHAR2 ( 200 CHAR ),
        country  VARCHAR2 ( 200 CHAR ),
        email varchar2(200),
        phone varchar2(200)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL 
                (seller_id integer external (6),
                 name char(200),
                 surname   char(200),
                 address char(200),
                 city char(200),
                 state char(200),
                 country char(200),
                 email char(200),
                 phone char(200))
             )
         LOCATION ('sellers.csv')
    )
    reject LIMIT unlimited;
    select count(*) from seller;
   commit;
  
  GRANT SELECT ON seller to bl_cl;
  