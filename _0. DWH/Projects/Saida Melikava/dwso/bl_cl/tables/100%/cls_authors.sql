EXECUTE pckg_drop.drop_proc(object_name=>'cls_authors', object_type=>'table');
CREATE TABLE cls_authors
  (
    author_code NUMBER(8),
    author_name VARCHAR2(250 CHAR)
  );