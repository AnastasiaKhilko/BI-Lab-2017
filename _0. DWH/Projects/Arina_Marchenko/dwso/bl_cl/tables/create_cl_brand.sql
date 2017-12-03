DROP TABLE cl_brand;
CREATE TABLE cl_brand
  ( 
  brand_name VARCHAR2(200) NOT NULL
  );
GRANT SELECT ON cl_brand TO bl_3nf;