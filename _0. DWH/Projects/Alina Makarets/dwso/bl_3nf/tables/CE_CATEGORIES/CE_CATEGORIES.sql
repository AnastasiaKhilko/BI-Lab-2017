DROP TABLE ce_categories cascade constraints;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_categories 
    (
        category_surr_id NUMBER   ( 10 )       NOT NULL,
        category_name    VARCHAR2 ( 200 CHAR ) NOT NULL,
        insert_dt        DATE DEFAULT '01-ЯНВ-1990',
        update_dt        DATE DEFAULT '31-ДЕК-9999',
		
        CONSTRAINT PK_category_id_3nf PRIMARY KEY ( category_surr_id )
        );
        
        
