EXECUTE pckg_drop.drop_proc(object_name=>'cls_catalog', object_type=>'table');
CREATE TABLE cls_catalog
  (
    cat_src_id  NUMBER(8),
    ISBN        VARCHAR2 ( 200 CHAR ),
    cat_id      NUMBER(8),
    book_name   VARCHAR2 ( 200 CHAR ),
    author_name VARCHAR2 ( 200 CHAR ),
    description VARCHAR2 ( 200 CHAR ),
    genre       VARCHAR2 ( 200 CHAR ),
    weight_kg   NUMBER(6,3),
    weight_mb   NUMBER(8,2),
    sym_num     NUMBER(8)
  ); 
  
  EXECUTE pckg_drop.drop_proc(object_name=>'cls_catalog_error', object_type=>'table');
CREATE TABLE cls_catalog_error
  (
   
    ISBN        VARCHAR2 ( 200 CHAR ),
    book_name   VARCHAR2 ( 200 CHAR ),
    author_name VARCHAR2 ( 200 CHAR ),
    description VARCHAR2 ( 200 CHAR ),
    genre       VARCHAR2 ( 200 CHAR ),
    weight_kg   VARCHAR2 ( 200 CHAR )
  ); 