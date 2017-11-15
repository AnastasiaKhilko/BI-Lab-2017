DROP TABLE STORES;

CREATE TABLE STORES (
        "Store_id" NUMBER(4) NOT NULL,
        "Store_name" VARCHAR2(40),
        "Phone" VARCHAR2(40),
        "Address_id" NUMBER(10),
        "Manager_id" NUMBER(10)
         );
        
ALTER TABLE STORES 
    ADD CONSTRAINT "PK_Store_id"
    PRIMARY KEY ("Store_id");
    
ALTER TABLE STORES 
    ADD CONSTRAINT "FK_Manager_id_Store"
    FOREIGN KEY ("Manager_id")
        REFERENCES EMPLOYEES("Employee_id");
        
ALTER TABLE STORES 
    ADD CONSTRAINT "FK_Address_id_Store"
    FOREIGN KEY ("Address_id")
        REFERENCES LOCATIONS("Address_id");