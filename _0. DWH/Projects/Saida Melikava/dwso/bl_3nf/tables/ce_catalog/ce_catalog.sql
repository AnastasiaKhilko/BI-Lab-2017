EXECUTE pckg_drop.drop_proc(object_name=>'ce_catalog', object_type=>'table');
CREATE TABLE ce_catalog
  (
    Prod_id          NUMBER(8) PRIMARY KEY,
    Prod_code        VARCHAR2(25) NOT NULL,
    Prod_category_id NUMBER(8) NOT NULL,
    Prod_name        VARCHAR2(150) NOT NULL,
    Prod_author_id   NUMBER(8) NOT NULL,
    Prod_description VARCHAR2(500) NOT NULL,
    Prod_genre_id    NUMBER(8) NOT NULL,
    Prod_weight_kg   NUMBER(3,3) NOT NULL,
    insert_DT        DATE DEFAULT(sysdate) NOT NULL ,
    update_DT        DATE DEFAULT(sysdate) NOT NULL
  );
ALTER TABLE ce_catalog ADD CONSTRAINT fk_prin_cat FOREIGN KEY (Prod_category_id) REFERENCES ce_categories(Category_id);
