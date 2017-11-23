-- CLS_BRA_SIZES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_bra_sizes', object_type => 'table');
END;

CREATE TABLE cls_bra_sizes
  (
    bra_size_uk  VARCHAR2 ( 200 CHAR ) NOT NULL,
    bra_size_usa VARCHAR2 ( 200 CHAR ) NOT NULL,
    bra_size_eu  VARCHAR2 ( 200 CHAR ) NOT NULL,
    bra_size_fr  VARCHAR2 ( 200 CHAR ) NOT NULL,
    bra_size_uie VARCHAR2 ( 200 CHAR ) NOT NULL
  );