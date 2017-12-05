EXECUTE pckg_drop.drop_proc(object_name=>'cls_addr', object_type=>'table');
CREATE TABLE cls_addr
  (
    addr_code         NUMBER(8),
    addr_street       VARCHAR2(250 CHAR),
    addr_number_house VARCHAR2(250 CHAR),
    addr_city         NUMBER(8)
  );
EXECUTE pckg_drop.drop_proc(object_name=>'cls_addr_error', object_type=>'table');
CREATE TABLE cls_addr_error
  (
    addr_street       VARCHAR2(250 CHAR),
    addr_number_house VARCHAR2(250 CHAR),
    addr_city         VARCHAR2(250 CHAR)
  ); 