DROP TABLE COLORS;

CREATE TABLE COLORS (
        "Color_id" NUMBER(4) NOT NULL,
        "Color_name" VARCHAR2(40),
        "Color_desc" VARCHAR2(80)
          );
        
ALTER TABLE COLORS 
    ADD CONSTRAINT "PK_Color_id"
    PRIMARY KEY ("Color_id");