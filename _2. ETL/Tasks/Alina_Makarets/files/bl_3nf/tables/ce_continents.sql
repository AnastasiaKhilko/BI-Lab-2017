CREATE TABLE ce_continents
  (
    continent_id   NUMBER(10,0) PRIMARY KEY ,
    continent_desc VARCHAR2 ( 200 CHAR ) NOT NULL,
    world_id NUMBER(10,0) NOT NULL,
    CONSTRAINT FK_world_id FOREIGN KEY (world_id) 
        REFERENCES ce_worlds (world_id) 
  );