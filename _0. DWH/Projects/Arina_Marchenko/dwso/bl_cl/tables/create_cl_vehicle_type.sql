-------------------------- vehicle type table -------------------
DROP TABLE cl_vehicle_type;
CREATE TABLE cl_vehicle_type
  ( vehicle_type_name VARCHAR2(200) NOT NULL
  );
GRANT SELECT ON cl_vehicle_type TO bl_3nf;