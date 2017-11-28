CREATE TABLE ce_country
  (
    country_id_seq NUMBER,
    country_num  NUMBER,
    country_name VARCHAR2 (200 CHAR),
    region_id NUMBER
  );
CREATE sequence COUNTRY_seq start with 1 increment BY 1 nocache nocycle;

--DROP TABLE CE_COUNTRY;
--drop sequence COUNTRY_seq;
