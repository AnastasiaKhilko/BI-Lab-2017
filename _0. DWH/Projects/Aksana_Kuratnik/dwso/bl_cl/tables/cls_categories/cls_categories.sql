-- CLS_CATEGORIES.
DROP TABLE cls_categories;
CREATE TABLE cls_categories
  (
    category_id   VARCHAR2 ( 200 CHAR ) NOT NULL,
    category_name VARCHAR2 ( 200 CHAR ),
    start_dt        DATE DEFAULT '01-JAN-1990',
    end_dt          DATE DEFAULT '31-DEC-9999',
    is_active       VARCHAR2 ( 200 CHAR ) NOT NULL
  );