EXECUTE pckg_drop.drop_proc(object_name=>'wrk_addr', object_type=>'table');
CREATE TABLE wrk_addr
  (
    addr_street       VARCHAR2(250 CHAR),
    addr_number_house VARCHAR2(250 CHAR),
    addr_city         VARCHAR2(250 CHAR)
  ); 