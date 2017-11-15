CREATE TABLE DIM_LOCATIONS (
        "Address_id" NUMBER(10) NOT NULL,
        "Address" VARCHAR2(40) NOT NULL,
        "Postal_code" VARCHAR2(40) NOT NULL,
        "City_id" NUMBER(4) NOT NULL,
        "City_name" VARCHAR2(40) NOT NULL,
        "Region_id" NUMBER(4) NOT NULL,
        "Region_name" VARCHAR2(40) NOT NULL,
        "Country_code" VARCHAR2(10) NOT NULL,
        "Country_name" VARCHAR2(40) NOT NULL,
        "Insert_dt" DATE NOT NULL,
        "Update_dt" DATE NOT NULL,
        CONSTRAINT "PK_Address_ID"
          PRIMARY KEY ("Address_id")
         );
