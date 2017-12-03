EXECUTE pckg_drop.drop_proc(object_name=>'cls_catalog', object_type=>'table');
CREATE TABLE cls_catalog
  (
    ISBN        VARCHAR2 ( 200 CHAR ),
    cat_id      NUMBER(8),
    book_name   VARCHAR2 ( 200 CHAR ),
    author_id   NUMBER(8),
    description VARCHAR2 ( 200 CHAR ),
    genre_id    NUMBER(8),
    weight_kg   NUMBER(6,3)
   
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