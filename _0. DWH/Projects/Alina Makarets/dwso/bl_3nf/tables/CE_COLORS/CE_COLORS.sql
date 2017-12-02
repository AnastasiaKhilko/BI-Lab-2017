DROP TABLE ce_colors cascade constraints;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_colors
    (
        color_surr_id NUMBER ( 10 )         NOT NULL,
        color_id      NUMBER ( 10 )         NOT NULL,
        color_name    VARCHAR2 ( 200 CHAR ) NOT NULL,
        insert_dt     DATE     DEFAULT '01-ßÍÂ-1990',
        update_dt     DATE     DEFAULT '31-ÄÅÊ-9999',
		
        CONSTRAINT PK_color_id_3nf       PRIMARY KEY ( color_surr_id ),
        CONSTRAINT UNQ_color_surr_id_3nf UNIQUE      ( color_id )
        );
        
