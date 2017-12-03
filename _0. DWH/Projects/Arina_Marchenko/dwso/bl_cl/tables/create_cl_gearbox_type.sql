---------------------gearbox type table-----------------------
DROP TABLE cl_gearbox_type;
CREATE TABLE cl_gearbox_type
  ( gearbox_type_name VARCHAR2(200) NOT NULL
  );
GRANT SELECT ON cl_gearbox_type TO bl_3nf;