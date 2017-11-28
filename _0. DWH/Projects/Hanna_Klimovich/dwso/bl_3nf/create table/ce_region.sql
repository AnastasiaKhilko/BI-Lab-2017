CREATE TABLE ce_region
  (
    region_id_seq NUMBER,
    region_num  NUMBER,
    region_name VARCHAR2 (200 CHAR)
  );
CREATE sequence region_seq start with 1 increment BY 1 nocache nocycle;

--DROP TABLE CE_REGION;