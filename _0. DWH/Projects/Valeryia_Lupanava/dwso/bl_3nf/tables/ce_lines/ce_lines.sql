CREATE TABLE ce_lines (
    line_srcid         NUMBER(10) NOT NULL,
    line_name          VARCHAR2(10 BYTE) NOT NULL,
    line_description   VARCHAR2(40 BYTE) NOT NULL,
    collection_srcid   NUMBER(10) NOT NULL,
    start_dt           DATE NOT NULL,
    end_dt             DATE NOT NULL,
    is_active          VARCHAR2(4) NOT NULL,
    CONSTRAINT line_srcid_pk PRIMARY KEY ( line_srcid ),
    CONSTRAINT collection_srcid_fk FOREIGN KEY ( collection_srcid )
        REFERENCES ce_collections ( collection_srcid )
);