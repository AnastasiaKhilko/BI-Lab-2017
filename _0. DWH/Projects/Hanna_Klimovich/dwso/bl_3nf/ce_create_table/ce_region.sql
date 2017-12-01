CREATE TABLE ce_region
  (
    region_id_seq NUMBER PRIMARY KEY NOT NULL,
    region_num  NUMBER NOT NULL,
    region_name VARCHAR2 (200 CHAR)NOT NULL
  );
CREATE sequence region_seq start with 1 increment BY 1 nocache nocycle;

--DROP TABLE CE_REGION;