CREATE TABLE countries (
    country_id   NUMBER(10) NOT NULL,
    region_id    NUMBER(10) NOT NULL,
    country      VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT country_id_pk PRIMARY KEY ( country_id ),
    CONSTRAINT region_id_fk FOREIGN KEY ( region_id )
        REFERENCES regions ( region_id )
);