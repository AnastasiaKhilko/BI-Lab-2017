-- CLS_EMPLOYEES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_employees', object_type => 'table');
END;

CREATE TABLE cls_employees
(
 employee_id          VARCHAR2 ( 100 CHAR ) NOT NULL,
 first_name           VARCHAR2 ( 100 CHAR ) NOT NULL,
 last_name            VARCHAR2 ( 100 CHAR ) NOT NULL,
 store_srcid          VARCHAR2 ( 100 CHAR ) NOT NULL,
 position_name        VARCHAR2 ( 100 CHAR ) NOT NULL,
 position_grade_id    VARCHAR2 ( 100 CHAR ) NOT NULL,
 work_experience      NUMBER ( 38 ) NOT NULL,
 email                VARCHAR2 ( 100 CHAR ) NOT NULL,
 phone                VARCHAR2 ( 100 CHAR ) NOT NULL
);