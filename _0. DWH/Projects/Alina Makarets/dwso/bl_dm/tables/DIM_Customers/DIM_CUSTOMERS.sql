DROP TABLE dim_customers CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE dim_customers
    (
        customer_id       NUMBER ( 10 )         NOT NULL,
        customer_surr_id  NUMBER ( 10 )         NOT NULL,
        last_name         VARCHAR2 ( 100 CHAR ) NOT NULL,
        first_name        VARCHAR2 ( 100 CHAR ) NOT NULL,
        middle_name       VARCHAR2 ( 100 CHAR ) NOT NULL,
        phone             VARCHAR2 ( 50 CHAR )  NOT NULL,
        email             VARCHAR2 (150 CHAR )  NOT NULL,
        age               NUMBER   ( 10 )       NOT NULL,
        discount          NUMBER   ( 10 )       NOT NULL,
        gender            VARCHAR2 ( 50 CHAR )  NOT NULL,
        city_id           NUMBER   ( 10 )       NOT NULL,
        city_name         VARCHAR2 ( 200 CHAR ) NOT NULL,
        region_id         NUMBER ( 10 )         NOT NULL,
        region_name       VARCHAR2 ( 200 CHAR ) NOT NULL,
        insert_dt         DATE     DEFAULT '01-ßÍÂ-1990',
        update_dt         DATE     DEFAULT '31-ÄÅÊ-9999',
        
        CONSTRAINT PK_customer_id_dm       PRIMARY KEY ( customer_id )
        );
        
        
 