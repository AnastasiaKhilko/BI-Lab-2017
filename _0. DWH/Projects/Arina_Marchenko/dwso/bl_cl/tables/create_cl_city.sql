DROP TABLE cl_city;
CREATE TABLE cl_city
  (
    city_name  VARCHAR2(200) NOT NULL,
    country_id NUMBER(6) NOT NULL
  ) ;
GRANT SELECT ON cl_city TO bl_3nf;