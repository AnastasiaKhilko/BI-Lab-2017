DROP TABLE ce_authors CASCADE CONSTRAINTS;
CREATE TABLE ce_authors
  (
    author_id   NUMBER(8) PRIMARY KEY,
    author_code NUMBER(8) NOT NULL,
    author_name VARCHAR2(250) NOT NULL,
    insert_DT   DATE DEFAULT(sysdate) NOT NULL ,
    update_DT   DATE DEFAULT(sysdate) NOT NULL
  ); 