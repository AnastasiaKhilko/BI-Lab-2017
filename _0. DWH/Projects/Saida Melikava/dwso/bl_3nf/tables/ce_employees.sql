DROP TABLE ce_employees CASCADE CONSTRAINTS;
CREATE TABLE ce_employees
  (
    Employee_id         NUMBER(8) PRIMARY KEY,
    Employee_code       VARCHAR2(8),
    Employee_surname    VARCHAR2(100) NOT NULL,
    Employee_name       VARCHAR2(100) NOT NULL,
    Employee_phone      VARCHAR2(30) NOT NULL,
    Employee_email      VARCHAR2(100) NOT NULL,
    Employee_dep_id     NUMBER(8) NOT NULL,
    Employee_manager_id NUMBER(8),
    Employee_store_id   NUMBER(8) NOT NULL,
    insert_DT        	DATE DEFAULT(sysdate) NOT NULL ,
    update_DT        	DATE DEFAULT(sysdate) NOT NULL
  );

