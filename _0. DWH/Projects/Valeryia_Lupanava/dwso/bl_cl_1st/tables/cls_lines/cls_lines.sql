-- CLS_LINES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_lines', object_type => 'table');
END;

CREATE TABLE cls_lines
  (
    line_id       NUMBER ( 38 ) NOT NULL,
    line_name     VARCHAR2 ( 200 CHAR ) NOT NULL,
    collection_id NUMBER ( 38 ) NOT NULL
  );