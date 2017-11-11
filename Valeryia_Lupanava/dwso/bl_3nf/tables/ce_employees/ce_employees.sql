CREATE TABLE employees (
    employee_id         NUMBER(10) NOT NULL,
    first_name          VARCHAR2(40 BYTE) NOT NULL,
    last_name           VARCHAR2(40 BYTE) NOT NULL,
    manager_id          NUMBER(10),
    store_id            NUMBER(10) NOT NULL,
    position_name       VARCHAR2(40 BYTE) NOT NULL,
    position_grade_id   NUMBER(10) NOT NULL,
    hire_date           DATE NOT NULL,
    fire_date           DATE,
    work_period         NUMBER(10) NOT NULL,
    email               VARCHAR2(40 BYTE) NOT NULL,
    phone               VARCHAR2(40 BYTE) NOT NULL,
    CONSTRAINT employee_id_pk PRIMARY KEY ( employee_id ),
    CONSTRAINT position_grade_id_fk FOREIGN KEY ( position_grade_id )
        REFERENCES position_grades ( position_grade_id ),
    CONSTRAINT store_id_fk FOREIGN KEY ( store_id )
        REFERENCES stores ( store_id )
);