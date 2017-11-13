CREATE TABLE position_grades (
    position_grade_id   NUMBER(10) NOT NULL,
    position_grade      VARCHAR2(40 BYTE) NOT NULL,
    work_period         NUMBER(10) NOT NULL,-- Amount of days.
    CONSTRAINT position_grade_id_pk PRIMARY KEY ( position_grade_id )
);