CREATE TABLE regions
  (
    region_id    NUMBER(10) PRIMARY KEY,
    region_desc  VARCHAR2 ( 100 CHAR ) NOT NULL,
    continent_id NUMBER(10) NOT NULL,
    CONSTRAINT fk_continent FOREIGN KEY (continent_id) REFERENCES continents(continent_id)
  );

INSERT INTO regions
SELECT * FROM bl_cl_task.cl_region;
COMMIT;