EXECUTE pckg_drop.drop_proc(object_name=>'ce_genres', object_type=>'table');
CREATE TABLE ce_genres
  (
    Genre_id   NUMBER(8) PRIMARY KEY,
    genre_code NUMBER(8) NOT NULL,
    genre_name VARCHAR2(250) NOT NULL,
    insert_DT  DATE DEFAULT(sysdate) NOT NULL ,
    update_DT  DATE DEFAULT(sysdate) NOT NULL
  ); 