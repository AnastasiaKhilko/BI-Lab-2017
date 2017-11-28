EXECUTE pckg_drop.drop_proc(object_name=>'cls_genre', object_type=>'table');
CREATE TABLE cls_genre
  (
    genre_src_id NUMBER(8),
    genre_name   VARCHAR2(250 CHAR)
  );