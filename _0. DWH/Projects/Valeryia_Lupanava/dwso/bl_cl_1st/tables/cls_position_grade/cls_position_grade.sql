-- CLS_POSITION_GRADE.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_position_grade', object_type => 'table');
END;

CREATE TABLE cls_position_grade
  (
    position_grade_id VARCHAR2 ( 200 CHAR ) NOT NULL,
    position_grade    VARCHAR2 ( 200 CHAR ) NOT NULL,
    work_experience   NUMBER ( 10 ) NOT NULL
  );