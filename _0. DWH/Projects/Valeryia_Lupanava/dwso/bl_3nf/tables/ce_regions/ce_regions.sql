BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_regions', Object_Type => 'table');
END;

CREATE TABLE ce_regions (
    region_srcid   NUMBER(10) NOT NULL,
    region         VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT region_id_pk PRIMARY KEY ( region_srcid )
);