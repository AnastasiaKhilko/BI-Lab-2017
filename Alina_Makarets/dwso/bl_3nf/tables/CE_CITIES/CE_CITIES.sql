CREATE TABLE CE_CITIES (
        "City_srcid" NUMBER(4) NOT NULL,
        "City_name" VARCHAR2(40),
        "Region_srcid" NUMBER(4),
        CONSTRAINT "PK_City_srcid"
            PRIMARY KEY ("City_srcid"),
        CONSTRAINT "FK_Region_srcid"
            FOREIGN KEY ("Region_srcid")
                 REFERENCES CE_REGIONS("Region_srcid")
        );
        
