CREATE TABLE lines (
    line_id            NUMBER(10) NOT NULL,
    line_name          VARCHAR2(10 BYTE),
    line_description   VARCHAR2(40 BYTE),
    collection_id      NUMBER(10) NOT NULL,
    CONSTRAINT line_id_pk PRIMARY KEY ( line_id ),
    CONSTRAINT collection_id_fk FOREIGN KEY ( collection_id )
        REFERENCES collections ( collection_id )
);