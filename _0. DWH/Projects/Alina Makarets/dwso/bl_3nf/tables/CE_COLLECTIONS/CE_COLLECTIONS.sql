DROP TABLE ce_collections cascade constraints;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_collections
  (
    collection_surr_id NUMBER   ( 38 )       NOT NULL,
    collection_name    VARCHAR2 ( 200 CHAR ) NOT NULL,
    insert_dt          DATE DEFAULT '01-ßÍÂ-1990',
    update_dt          DATE DEFAULT '31-ÄÅÊ-9999',
	
    CONSTRAINT PK_collection_id_3nf PRIMARY KEY ( collection_surr_id )
  );
  
                 