DROP TABLE shops;
CREATE TABLE SHOPS
  (
    shop_id   NUMBER ( 10 ),
    shop_name VARCHAR2 ( 200 ),
    phone     VARCHAR2 ( 200),
    email     VARCHAR2 ( 200),
    address   VARCHAR2 ( 200 ),
    country   VARCHAR2 ( 200 ),
    city      VARCHAR2 ( 200 )
  )
  ORGANIZATION EXTERNAL
  (
    TYPE ORACLE_LOADER 
    DEFAULT DIRECTORY ext_tables 
    ACCESS PARAMETERS (RECORDS DELIMITED BY 0x'0D0A' 
    nobadfile nodiscardfile nologfile 
    fields terminated BY ',' 
    missing field VALUES are NULL 
    (shop_id INTEGER external (4), 
     shop_name CHAR(200), 
     phone CHAR(200), 
     email CHAR(200), 
     address CHAR(200), 
     country CHAR(200), 
     city CHAR(200)) 
     ) LOCATION ('shops.csv')
  )
  reject LIMIT unlimited;
SELECT COUNT(*) FROM shops;
COMMIT;
GRANT
SELECT ON shops TO bl_cl; 