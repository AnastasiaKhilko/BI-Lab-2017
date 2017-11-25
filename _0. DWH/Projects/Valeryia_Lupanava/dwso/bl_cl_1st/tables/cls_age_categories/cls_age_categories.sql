-- CLS_AGE_CATEGORIES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_age_categories', object_type => 'table');
END;

CREATE TABLE cls_age_categories
  (
    age_category_id NUMBER ( 10 ) NOT NULL,
    age_category    VARCHAR2 ( 200 CHAR ) NOT NULL
  );