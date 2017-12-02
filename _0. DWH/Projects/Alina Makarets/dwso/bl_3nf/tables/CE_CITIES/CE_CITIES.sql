DROP TABLE ce_cities cascade constraints;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_cities
    (
        city_surr_id    NUMBER ( 10 )         NOT NULL,
        city_name       VARCHAR2 ( 200 CHAR ) NOT NULL,
        region_surr_id  NUMBER ( 10 )         NOT NULL,
        insert_dt       DATE     DEFAULT '01-ßÍÂ-1990',
        update_dt       DATE     DEFAULT '31-ÄÅÊ-9999',
        
        CONSTRAINT PK_city_id_3nf   PRIMARY KEY ( city_surr_id ),
        CONSTRAINT FK_region_id_3nf FOREIGN KEY ( region_surr_id )
                  REFERENCES ce_regions         ( region_surr_id )
        );
        
        
 