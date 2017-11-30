DROP TABLE dim_employees CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE dim_employees
    (
        employee_id       NUMBER ( 10 )         NOT NULL,
        employee_surr_id  NUMBER ( 10 )         NOT NULL,
        last_name         VARCHAR2 ( 100 CHAR ) NOT NULL,
        first_name        VARCHAR2 ( 100 CHAR ) NOT NULL,
        middle_name       VARCHAR2 ( 100 CHAR ) NOT NULL,
        phone             VARCHAR2 ( 50 CHAR )  NOT NULL,
        email             VARCHAR2 (150 CHAR )  NOT NULL,
        age               NUMBER   ( 10 )       NOT NULL,
        gender            VARCHAR2 ( 50 CHAR )  NOT NULL,
        passport          VARCHAR2 ( 100 CHAR ) NOT NULL,
        start_dt          DATE     DEFAULT '01-ßÍÂ-1990',
        end_dt            DATE     DEFAULT '31-ÄÅÊ-9999',
        is_active         VARCHAR2 ( 10 CHAR )  NOT NULL,
        
        CONSTRAINT PK_employee_id_dm  PRIMARY KEY ( employee_id )
        );
        
        
 