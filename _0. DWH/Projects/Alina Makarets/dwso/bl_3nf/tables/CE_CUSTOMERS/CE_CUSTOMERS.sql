DROP TABLE ce_customers CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_customers
    (
        customer_surr_id  NUMBER ( 38 )         NOT NULL,
        customer_id       VARCHAR2 ( 100 CHAR ) NOT NULL,
        last_name         VARCHAR2 ( 100 CHAR ) NOT NULL,
        first_name        VARCHAR2 ( 100 CHAR ) NOT NULL,
        middle_name       VARCHAR2 ( 100 CHAR ) NOT NULL,
        phone             VARCHAR2 ( 50 CHAR )  NOT NULL,
        email             VARCHAR2 (150 CHAR )  NOT NULL,
        age               NUMBER   ( 10 )       NOT NULL,
        discount          NUMBER   ( 10 )       NOT NULL,
        gender            VARCHAR2 ( 50 CHAR )  NOT NULL,
        city_surr_id      NUMBER   ( 10 )       NOT NULL,
        insert_dt         DATE     DEFAULT '01-ßÍÂ-1990',
        update_dt         DATE     DEFAULT '31-ÄÅÊ-9999',
        
        CONSTRAINT PK_customer_id_3nf       PRIMARY KEY ( customer_surr_id ),
        CONSTRAINT UNQ_customer_surr_id_3nf UNIQUE      ( customer_id ),
        CONSTRAINT FK_city_id_3nf           FOREIGN KEY ( city_surr_id )
                   REFERENCES ce_cities                 ( city_surr_id )   
        );
        
        
 