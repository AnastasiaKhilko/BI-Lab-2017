CREATE TABLE DIM_COLLECTIONS (
        "Collection_id" NUMBER(4) NOT NULL,
        "Collection_name" VARCHAR2(40) NOT NULL,
        "Collection_date" DATE NOT NULL,
        "Collection_desc" VARCHAR2(80) NOT NULL,
        "Insert_dt" DATE NOT NULL,
        "Start_dt" DATE NOT NULL,
        "End_dt" DATE NOT NULL,
        "Is_active" VARCHAR(4) NOT NULL,
        CONSTRAINT "PK_Collection_id"
          PRIMARY KEY ("Collection_id"),
        CONSTRAINT "FK_Collection_date"
          FOREIGN KEY ("Collection_date")
            REFERENCES DIM_TIME_DAY("Date_id")
          );
