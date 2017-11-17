CREATE TABLE ce_collections (
    collection_srcid         NUMBER(10) NOT NULL,
    collection_name          VARCHAR2(10 BYTE),
    season_srcid             NUMBER(10) NOT NULL,
    collection_description   VARCHAR2(40 BYTE),
    collection_dt            DATE NOT NULL,
    start_dt                 DATE NOT NULL,
    end_dt                   DATE NOT NULL,
    is_active                VARCHAR2(4) NOT NULL,
    CONSTRAINT collection_srcid_pk PRIMARY KEY ( collection_srcid ),
    CONSTRAINT season_srcid_fk FOREIGN KEY ( season_srcid )
        REFERENCES ce_seasons ( season_srcid )
);