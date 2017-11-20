  CREATE TABLE global
  (
    global_id   NUMBER(10) PRIMARY KEY ,
    global_desc VARCHAR2 ( 100 CHAR ) NOT NULL
  );
INSERT INTO global
SELECT * FROM bl_cl_task.cl_global;
commit;