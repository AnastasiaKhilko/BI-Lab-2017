CREATE TABLE ce_authors
  (
    Author_code VARCHAR2(25) PRIMARY KEY,
    Author_name VARCHAR2(70) NOT NULL,
    insert_DT   DATE NOT NULL,
    update_DT   DATE NOT NULL
  );
