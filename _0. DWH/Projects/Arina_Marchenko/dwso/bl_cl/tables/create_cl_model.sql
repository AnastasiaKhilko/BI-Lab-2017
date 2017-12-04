DROP TABLE cl_model;
CREATE TABLE cl_model
  (
    model_name VARCHAR2(200) NOT NULL,
    brand_id   NUMBER(6) NOT NULL
  ) ;
GRANT SELECT ON cl_model TO bl_3nf;