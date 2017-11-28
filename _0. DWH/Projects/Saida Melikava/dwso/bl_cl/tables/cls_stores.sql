EXECUTE pckg_drop.drop_proc(object_name=>'cls_stores', object_type=>'table');
CREATE TABLE cls_stores
  (
    store_src_id NUMBER(8),
    code         VARCHAR2 ( 200 CHAR ),
    name         VARCHAR2 ( 200 CHAR ),
    phone        VARCHAR2 ( 200 CHAR ),
    address_id   NUMBER(8),
    manager_id   NUMBER(8)
  );
