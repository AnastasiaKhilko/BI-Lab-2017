CREATE TABLE CE_REGIONS (
        "Region_srcid" NUMBER(4) NOT NULL,
        "Region_name" VARCHAR2(40),
        "Country_srcid" NUMBER(10),
        CONSTRAINT "PK_Region_srcid"
          PRIMARY KEY ("Region_srcid"),
        CONSTRAINT "FK_Country_srcid"
          FOREIGN KEY ("Country_srcid")
            REFERENCES CE_COUNTRIES("Country_srcid")
         );
        