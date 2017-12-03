drop table orders;
CREATE TABLE orders
        (order_code VARCHAR2 ( 200  ),
         cost number(8),
         minPrice number(8),
         maxPrice number(8),
         avgPrice VARCHAR2 ( 200  ),
         sdPrice VARCHAR2 ( 200  ),
         start_dt VARCHAR2 ( 200  ),
         end_dt VARCHAR2 ( 200  )
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL 
                (order_code char (200),
                cost integer external (6),
                minPrice integer external (6),
                maxPrice integer external (6),
                avgPrice char (200),
                sdPrice char (200),
                start_dt char (200),
                end_dt CHAR(100) )
             )
         LOCATION ('orders_v2.csv')
    )
    reject LIMIT unlimited;
    select count(*) from orders;
    commit;
  
  GRANT SELECT ON orders to bl_cl;