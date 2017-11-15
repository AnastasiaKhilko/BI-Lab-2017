CREATE TABLE ce_countries (
    country_srcid   NUMBER(10) NOT NULL,
    region_srcid    NUMBER(10) NOT NULL,
    country         VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT country_srcid_pk PRIMARY KEY ( country_srcid ),
    CONSTRAINT region_srcid_fk FOREIGN KEY ( region_srcid )
        REFERENCES ce_regions ( region_srcid )
);