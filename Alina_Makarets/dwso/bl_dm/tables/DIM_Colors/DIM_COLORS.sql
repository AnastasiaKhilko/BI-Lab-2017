CREATE TABLE DIM_COLORS (
        "Color_id" NUMBER(4) NOT NULL,
        "Color_name" VARCHAR2(40) NOT NULL,
        "Color_desc" VARCHAR2(80) NOT NULL,
        "Insert_dt" DATE NOT NULL,
        "Update_dt" DATE NOT NULL,
        CONSTRAINT "PK_Color_id"
          PRIMARY KEY ("Color_id")
          );
