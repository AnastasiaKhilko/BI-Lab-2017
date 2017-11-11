CREATE TABLE dim_employees (
    employee_id         NUMBER(10) NOT NULL,
    first_name          VARCHAR2(40 BYTE) NOT NULL,
    last_name           VARCHAR2(40 BYTE) NOT NULL,
    store_id            NUMBER(10) NOT NULL,
    position_name       VARCHAR2(40 BYTE) NOT NULL,
    position_grade      VARCHAR2(40 BYTE) NOT NULL,
    hire_date           DATE NOT NULL,
    fire_date           DATE,
    work_period         NUMBER(10) NOT NULL,
    email               VARCHAR2(40 BYTE) NOT NULL,
    phone               VARCHAR2(40 BYTE) NOT NULL,
    manager_id          NUMBER(10),
    m_first_name          VARCHAR2(40 BYTE) NOT NULL,
    m_last_name           VARCHAR2(40 BYTE) NOT NULL,
    m_position_name       VARCHAR2(40 BYTE) NOT NULL,
    CONSTRAINT employee_id_pk PRIMARY KEY ( employee_id )
);