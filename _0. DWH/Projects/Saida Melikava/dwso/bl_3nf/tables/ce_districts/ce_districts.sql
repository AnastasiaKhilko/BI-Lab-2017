EXECUTE pckg_drop.drop_proc(object_name=>'ce_districts', object_type=>'table');
EXECUTE pckg_drop.drop_proc(object_name=>'seq_distr_3NF', object_type=>'sequence');

CREATE TABLE ce_districts
  (
    district_id  NUMBER(8) PRIMARY KEY,
    district_code     VARCHAR2(60) NOT NULL,
    district_desc  VARCHAR2(60) NOT NULL,
    insert_DT   DATE default(sysdate) NOT NULL ,
    update_DT   DATE default(sysdate) NOT NULL
  );
  