CREATE TABLE dim_employees_scd (
    employee_surr_id   NUMBER(10) NOT NULL,
    employee_id        VARCHAR2(40 BYTE) NOT NULL,
    employee_desc      VARCHAR2(40 BYTE) NOT NULL,
    first_name         VARCHAR2(40 BYTE) NOT NULL,
    last_name          VARCHAR2(40 BYTE) NOT NULL,
    store_id           NUMBER(10) NOT NULL,
    position_name      VARCHAR2(40 BYTE) NOT NULL,
    position_grade     VARCHAR2(40 BYTE) NOT NULL,
    work_period        NUMBER(10) NOT NULL,
    email              VARCHAR2(40 BYTE) NOT NULL,
    phone              VARCHAR2(40 BYTE) NOT NULL,
    manager_surr_id    NUMBER(10) DEFAULT '-99',
    start_dt           DATE NOT NULL,
    end_dt             DATE NOT NULL,
    is_active          VARCHAR2(4) NOT NULL,
    CONSTRAINT employee_surr_id_pk PRIMARY KEY ( employee_surr_id )
);

/*ALTER TABLE dim_employees_scd
    ADD CONSTRAINT fk_manager_surr_id FOREIGN KEY ( manager_surr_id )
        REFERENCES dim_employees_scd ( manager_surr_id )
           ON DELETE CASCADE;*/