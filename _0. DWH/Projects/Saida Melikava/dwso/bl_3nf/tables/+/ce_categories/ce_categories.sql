CREATE TABLE ce_categories
  (
    Category_id   VARCHAR2(8) PRIMARY KEY,
    Category_name VARCHAR2(35) NOT NULL,
    Category_description VARCHAR2(250) NOT NULL,
    insert_DT      DATE NOT NULL,
    update_DT      DATE NOT NULL
  );
