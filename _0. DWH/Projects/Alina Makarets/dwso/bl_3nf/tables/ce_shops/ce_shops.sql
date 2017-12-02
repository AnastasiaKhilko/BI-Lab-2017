DROP TABLE ce_shops CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_shops
    (
        shop_surr_id      NUMBER ( 10 )         NOT NULL,
        shop_id           VARCHAR2 ( 100 CHAR ) NOT NULL,
        shop_name         VARCHAR2 ( 100 CHAR ) NOT NULL,
        phone             VARCHAR2 ( 50 CHAR )  NOT NULL,
        address           VARCHAR2 ( 200 CHAR ) NOT NULL,
        city_surr_id      NUMBER   ( 10 )       NOT NULL,
        manager_id        NUMBER   ( 10 )       NOT NULL,
        insert_dt         DATE     DEFAULT '01-ßÍÂ-1990',
        update_dt         DATE     DEFAULT '31-ÄÅÊ-9999',
        
        CONSTRAINT PK_shop_id_3nf       PRIMARY KEY ( shop_surr_id ),
        CONSTRAINT UNQ_shop_surr_id_3nf UNIQUE      ( shop_id ),
        CONSTRAINT FK_city2_id_3nf      FOREIGN KEY ( city_surr_id )
                   REFERENCES ce_cities             ( city_surr_id ),
        CONSTRAINT FK_manager_id_3nf    FOREIGN KEY ( manager_id )
                   REFERENCES ce_employees          ( employee_id )          
        );
        
        
 