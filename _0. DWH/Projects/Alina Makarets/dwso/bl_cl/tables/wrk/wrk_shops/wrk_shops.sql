-- WRK_SHOPS.
DROP TABLE WRK_SHOPS;

CREATE TABLE WRK_SHOPS
  (
    shop_code         VARCHAR2 ( 200 CHAR ),
    city              VARCHAR2 ( 200 BYTE ),
    shop_name         VARCHAR2 ( 200 BYTE ),
    address           VARCHAR2 ( 200 BYTE ),
    address_number    NUMBER   ( 20 ),
    phone             VARCHAR2 ( 200 BYTE ),
    region            VARCHAR2 ( 200 BYTE ),
    manager_code      VARCHAR2 ( 100 CHAR )
  );