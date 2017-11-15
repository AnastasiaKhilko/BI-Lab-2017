CREATE TABLE CE_COUNTRIES (
        "Country_srcid" NUMBER(10) NOT NULL,
        "Country_name" VARCHAR2(40),
        "Country_code" VARCHAR2(10),
        CONSTRAINT "PK_Country_srcid"
          PRIMARY KEY ("Country_srcid")
         );
        
