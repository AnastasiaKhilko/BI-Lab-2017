DROP TABLE cl_seller;
CREATE TABLE cl_seller
  (
    seller_code NUMBER(6) NOT NULL,
    name        VARCHAR2(200) NOT NULL,
    surname     VARCHAR2(200) NOT NULL,
    phone       VARCHAR2(200) NOT NULL,
    email       VARCHAR2(200) NOT NULL,
    city_id     NUMBER(6) NOT NULL
  ) ;
GRANT SELECT ON cl_seller TO bl_3nf;