DROP TABLE LOCATIONS;

CREATE TABLE LOCATIONS (
        "Address_id" NUMBER(10) NOT NULL,
        "Country_name" VARCHAR2(40),
        "Country_code" VARCHAR2(10),
        "Region_name" VARCHAR2(40),
        "Region_id" NUMBER(4),
        "City_name" VARCHAR2(40),
        "City_id" NUMBER(4),
        "Address" VARCHAR2(40),
        "Postal_code" VARCHAR2(40)
         );
        
ALTER TABLE LOCATIONS 
    ADD CONSTRAINT "PK_Address_ID"
    PRIMARY KEY ("Address_id");