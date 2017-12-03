DROP TABLE cl_address;
CREATE TABLE cl_address
  (
    address_name VARCHAR2(200) NOT NULL,
    city_id      NUMBER(6) NOT NULL
  ) ;
GRANT SELECT ON cl_address TO bl_3nf;