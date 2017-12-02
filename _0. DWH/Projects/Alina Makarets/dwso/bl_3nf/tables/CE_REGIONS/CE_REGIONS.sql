DROP TABLE ce_regions cascade constraints;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_regions
    (
        region_surr_id NUMBER ( 10 )         NOT NULL,
        region_id      VARCHAR2 ( 100 )      NOT NULL,
        region_name    VARCHAR2 ( 200 CHAR ) NOT NULL,
        insert_dt      DATE     DEFAULT '01-ßÍÂ-1990',
        update_dt      DATE     DEFAULT '31-ÄÅÊ-9999',
        
        CONSTRAINT PK_region_id_3nf  PRIMARY KEY ( region_surr_id )
        );
        
        
 