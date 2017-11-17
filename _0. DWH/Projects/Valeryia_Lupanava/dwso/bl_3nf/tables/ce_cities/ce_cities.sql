CREATE TABLE ce_cities (
    city_srcid      NUMBER(10) NOT NULL,
    country_srcid   NUMBER(10) NOT NULL,
    city            VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT city_srcid_pk PRIMARY KEY ( city_srcid ),
    CONSTRAINT country_srcid_fk FOREIGN KEY ( country_srcid )
        REFERENCES ce_countries ( country_srcid )
);