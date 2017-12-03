---------------------repaired status table-----------------------
DROP TABLE cl_repaired_status;
CREATE TABLE cl_repaired_status
  (
    repaired_status_name VARCHAR2(200) NOT NULL
  );
GRANT SELECT ON cl_repaired_status TO bl_3nf;