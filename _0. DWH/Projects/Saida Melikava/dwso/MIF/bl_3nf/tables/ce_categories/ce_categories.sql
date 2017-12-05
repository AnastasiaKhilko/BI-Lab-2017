EXECUTE pckg_drop.drop_proc(object_name=>'ce_categories', object_type=>'table');
CREATE TABLE ce_categories
  (
    Category_id          NUMBER(8) PRIMARY KEY,
    Category_name        VARCHAR2(35) NOT NULL,
    Category_description VARCHAR2(500) NOT NULL,
    insert_DT            DATE DEFAULT(sysdate) NOT NULL ,
    update_DT            DATE DEFAULT(sysdate) NOT NULL
  );
