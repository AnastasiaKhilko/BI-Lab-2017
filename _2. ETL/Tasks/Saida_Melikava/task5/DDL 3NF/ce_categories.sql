DROP TABLE ce_categories CASCADE CONSTRAINTS;
CREATE TABLE ce_categories
  (
    Category_id          NUMBER(8) PRIMARY KEY,
    Category_name        VARCHAR2(80) NOT NULL,
    Category_description VARCHAR2(800) NOT NULL,
    insert_DT            DATE DEFAULT(sysdate) NOT NULL ,
    update_DT            DATE DEFAULT(sysdate) NOT NULL
  );
