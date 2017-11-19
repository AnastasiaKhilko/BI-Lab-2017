CREATE TABLE ce_departments
  (
    Department_id   NUMBER(8) PRIMARY KEY,
    Department_name VARCHAR2(30) NOT NULL,
    insert_DT       DATE NOT NULL,
    update_DT       DATE NOT NULL
  );