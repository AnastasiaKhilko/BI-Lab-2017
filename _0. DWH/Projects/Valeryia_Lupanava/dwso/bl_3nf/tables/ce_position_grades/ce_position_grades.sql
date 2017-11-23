BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_position_grades', Object_Type => 'table');
END;

CREATE TABLE ce_position_grades (
    position_grade_srcid   NUMBER(10) NOT NULL,
    position_grade         VARCHAR2(40 BYTE) NOT NULL,
    work_period            NUMBER(10) NOT NULL,-- Amount of days.
    CONSTRAINT position_grade_srcid_pk PRIMARY KEY ( position_grade_srcid )
);