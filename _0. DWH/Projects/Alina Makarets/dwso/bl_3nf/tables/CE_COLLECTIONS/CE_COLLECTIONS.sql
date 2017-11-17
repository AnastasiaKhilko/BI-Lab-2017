CREATE TABLE CE_COLLECTIONS (
        "Collection_srcid" NUMBER(4) NOT NULL,
        "Collection_name" VARCHAR2(40),
        "Collection_date" DATE,
        "Collection_desc" VARCHAR2(80),
        "Start_dt" DATE NOT NULL,
        "End_dt" DATE NOT NULL,
        "Is_active" VARCHAR(4) NOT NULL,
        CONSTRAINT "PK_Collection_srcid"
           PRIMARY KEY ("Collection_srcid"),
        CONSTRAINT "FK_Collection_date"
          FOREIGN KEY ("Collection_date")
            REFERENCES CE_DATE("Date_srcid")
          );
        