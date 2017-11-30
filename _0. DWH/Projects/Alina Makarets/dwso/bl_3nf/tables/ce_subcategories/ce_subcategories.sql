DROP TABLE ce_subcategories cascade constraints;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_subcategories
    (
        subcategory_surr_id NUMBER   ( 10 )       NOT NULL,
        subcategory_name    VARCHAR2 ( 200 CHAR ) NOT NULL,
        category_surr_id    NUMBER   ( 10 )       NOT NULL,
        insert_dt           DATE DEFAULT '01-ßÍÂ-1990',
        update_dt           DATE DEFAULT '31-ÄÅÊ-9999',
        
        CONSTRAINT PK_subcategory_id_3nf PRIMARY KEY ( subcategory_surr_id ),
        CONSTRAINT FK_category_id_3nf    FOREIGN KEY ( category_surr_id )
                   REFERENCES ce_categories          ( category_surr_id )
        );

 