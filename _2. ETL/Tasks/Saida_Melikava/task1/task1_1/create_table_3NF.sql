CREATE TABLE globals
  (
    global_id   NUMBER(10,0) PRIMARY KEY ,
    global_desc VARCHAR2 ( 200 CHAR ) NOT NULL
  );

CREATE TABLE continents
  (
    continent_id   NUMBER(10,0) PRIMARY KEY ,
    continent_desc VARCHAR2 ( 200 CHAR ) NOT NULL,
    global_id NUMBER(10,0) NOT NULL,
    CONSTRAINT gk_glob FOREIGN KEY (global_id) REFERENCES globals(global_id) 
  );
  
CREATE TABLE regions
  (
    region_id    NUMBER(10,0) PRIMARY KEY,
    region_desc  VARCHAR2 ( 200 CHAR ) NOT NULL,
    continent_id NUMBER(10,0) NOT NULL,
    CONSTRAINT fk_cont FOREIGN KEY (continent_id) REFERENCES continents(continent_id)
  );
  
CREATE TABLE countries
  (
    country_id   NUMBER(10,0) PRIMARY KEY NOT NULL,
    country_desc VARCHAR2 ( 200 CHAR ) NOT NULL,
    country_code VARCHAR2 ( 3 ),
    region_id    NUMBER(10,0)NOT NULL ,
    CONSTRAINT fk_reg FOREIGN KEY (region_id) REFERENCES regions(region_id)
  );
  
INSERT INTO globals
SELECT * FROM bl_cl.cl_global;

INSERT INTO continents
SELECT * FROM bl_cl.cl_continents;

INSERT INTO regions
SELECT * FROM bl_cl.cl_regions;

INSERT INTO countries
SELECT * FROM bl_cl.cl_countries;

COMMIT;
  
  