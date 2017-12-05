DROP TABLE ce_districts CASCADE CONSTRAINTS;
CREATE TABLE ce_districts
  (
    district_id  NUMBER(8) PRIMARY KEY,
    district_code     VARCHAR2(60) NOT NULL,
    district_desc  VARCHAR2(60) NOT NULL,
    insert_DT   DATE default(sysdate) NOT NULL ,
    update_DT   DATE default(sysdate) NOT NULL
  );
  