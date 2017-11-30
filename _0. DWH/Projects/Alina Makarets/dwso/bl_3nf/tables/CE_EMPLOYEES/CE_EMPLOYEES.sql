DROP TABLE ce_employees CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_employees
    (
        employee_surr_id  NUMBER ( 10 )         NOT NULL,
        employee_id       NUMBER ( 10 )         NOT NULL,
        last_name         VARCHAR2 ( 100 CHAR ) NOT NULL,
        first_name        VARCHAR2 ( 100 CHAR ) NOT NULL,
        middle_name       VARCHAR2 ( 100 CHAR ) NOT NULL,
        phone             VARCHAR2 ( 50 CHAR )  NOT NULL,
        email             VARCHAR2 (150 CHAR )  NOT NULL,
        age               NUMBER   ( 10 )       NOT NULL,
        gender            VARCHAR2 ( 50 CHAR )  NOT NULL,
        passport          VARCHAR2 ( 100 CHAR ) NOT NULL,
        start_dt          DATE     DEFAULT '01-ßÍÂ-1990' NOT NULL,
        end_dt            DATE     DEFAULT '31-ÄÅÊ-9999' NOT NULL,
        is_active         VARCHAR2 ( 10 CHAR )  NOT NULL,
        
        CONSTRAINT PK_employee_id_3nf       PRIMARY KEY ( employee_surr_id ),
        CONSTRAINT UNQ_employee_surr_id_3nf UNIQUE      ( employee_id )
        );
        
        
 