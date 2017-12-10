CREATE TABLE countries
  (
    country_id   NUMBER(10) PRIMARY KEY NOT NULL,
    country_desc VARCHAR2 ( 100 CHAR ) NOT NULL,
    country_code VARCHAR2 ( 5 ),
    region_id    NUMBER(10)NOT NULL ,
    CONSTRAINT fk_regions FOREIGN KEY (region_id) REFERENCES regions(region_id)
  );
INSERT INTO countries
SELECT * FROM bl_cl_task.cl_country;
COMMIT;
