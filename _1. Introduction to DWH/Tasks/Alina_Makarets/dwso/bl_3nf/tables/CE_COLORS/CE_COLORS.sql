CREATE TABLE CE_COLORS (
        "Color_srcid" NUMBER(4) NOT NULL,
        "Color_name" VARCHAR2(40),
        "Category_desc" VARCHAR2(80),
        CONSTRAINT "PK_Color_srcid"
            PRIMARY KEY ("Color_srcid")
          );
