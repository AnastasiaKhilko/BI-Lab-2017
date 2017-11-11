CREATE TABLE seasons (
    season_id   NUMBER(10) NOT NULL,
    season      VARCHAR2(10 BYTE) NOT NULL,
    CONSTRAINT season_id_pk PRIMARY KEY ( season_id )
);