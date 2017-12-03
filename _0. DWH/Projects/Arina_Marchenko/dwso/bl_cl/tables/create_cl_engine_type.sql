DROP TABLE cl_engine_type;
CREATE TABLE cl_engine_type
  ( engine_type_name VARCHAR2(200) NOT NULL
  );
GRANT SELECT ON cl_engine_type TO bl_3nf;