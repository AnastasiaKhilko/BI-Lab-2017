CREATE TABLE collections (
    collection_id            NUMBER(10) NOT NULL,
    collection_name          VARCHAR2(10 BYTE),
    season_id                NUMBER(10) NOT NULL,
    collection_description   VARCHAR2(40 BYTE),
    collection_date          DATE NOT NULL,
    CONSTRAINT collection_id_pk PRIMARY KEY ( collection_id ),
    CONSTRAINT season_id_fk FOREIGN KEY ( season_id )
        REFERENCES seasons ( season_id )
);