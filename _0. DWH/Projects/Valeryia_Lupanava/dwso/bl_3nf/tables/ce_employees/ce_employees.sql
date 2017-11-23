BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_employees', Object_Type => 'table');
END;

CREATE TABLE ce_employees (
    employee_id            NUMBER(10) NOT NULL,
    first_name             VARCHAR2(40 BYTE) NOT NULL,
    last_name              VARCHAR2(40 BYTE) NOT NULL,
    manager_srcid             NUMBER(10) DEFAULT '-99',
    store_srcid            NUMBER(10) NOT NULL,
    position_name          VARCHAR2(40 BYTE) NOT NULL,
    position_grade_srcid   NUMBER(10) NOT NULL,
    work_period            NUMBER(10) NOT NULL,
    email                  VARCHAR2(40 BYTE) NOT NULL,
    phone                  VARCHAR2(40 BYTE) NOT NULL,
    start_dt               DATE NOT NULL,
    end_dt                 DATE NOT NULL,
    is_active              VARCHAR2(4) NOT NULL,
    CONSTRAINT employee_id_pk PRIMARY KEY ( employee_id ),
    CONSTRAINT position_grade_srcid_fk FOREIGN KEY ( position_grade_srcid )
        REFERENCES ce_position_grades ( position_grade_srcid ),
    CONSTRAINT store_srcid_fk FOREIGN KEY ( store_srcid )
        REFERENCES ce_stores ( store_srcid )
);