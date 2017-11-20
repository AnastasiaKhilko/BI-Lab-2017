CREATE TABLE continents
  (
    continent_id   NUMBER(10) PRIMARY KEY ,
    continent_desc VARCHAR2 ( 100 CHAR ) NOT NULL,
    global_id NUMBER(10) NOT NULL,
    CONSTRAINT fk_global FOREIGN KEY (global_id) REFERENCES global(global_id) 
  );

INSERT INTO continents
SELECT * FROM bl_cl_task.cl_continent;
COMMIT;
