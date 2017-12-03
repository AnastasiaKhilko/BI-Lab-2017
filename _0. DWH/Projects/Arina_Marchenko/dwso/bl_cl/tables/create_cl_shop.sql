DROP TABLE cl_shop cascade constraints;
CREATE TABLE cl_shop
  (
    shop_code  NUMBER(6) NOT NULL,
    shop_name  VARCHAR2(200) NOT NULL,
    phone      VARCHAR2(200) NOT NULL,
    email      VARCHAR2(200) NOT NULL,
    address_id NUMBER(6) NOT NULL
  ) ;
GRANT SELECT ON cl_shop TO bl_3nf;