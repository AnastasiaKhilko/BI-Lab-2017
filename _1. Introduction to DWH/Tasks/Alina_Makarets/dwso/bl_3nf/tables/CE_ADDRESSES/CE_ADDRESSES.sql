CREATE TABLE CE_ADDRESSES (
        "Address_srcid" NUMBER(10) NOT NULL,
        "Address" VARCHAR2(40),
        "Postal_code" VARCHAR2(40),
        "City_srcid" NUMBER(4),
        CONSTRAINT "PK_Address_srcid"
          PRIMARY KEY ("Address_srcid"),
        CONSTRAINT "FK_City_srcid"
          FOREIGN KEY ("City_srcid")
            REFERENCES CE_CITIES("City_srcid")
         );
