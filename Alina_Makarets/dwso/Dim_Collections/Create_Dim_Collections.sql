DROP TABLE COLLECTIONS;

CREATE TABLE COLLECTIONS (
        "Collection_id" NUMBER(4) NOT NULL,
        "Collection_name" VARCHAR2(40),
        "Collection_date" DATE,
        "Collection_desc" VARCHAR2(80)
          );
        
ALTER TABLE COLLECTIONS 
    ADD CONSTRAINT "PK_Collection_id"
    PRIMARY KEY ("Collection_id");
  
ALTER TABLE COLLECTIONS 
    ADD CONSTRAINT "FK_Collection_date"
    FOREIGN KEY ("Collection_date")
        REFERENCES DATE_DIM("Date_id");