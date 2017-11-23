BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_seasons', Object_Type => 'table');
END;

CREATE TABLE ce_seasons (
    season_srcid   NUMBER(10) NOT NULL,
    season         VARCHAR2(10 BYTE) NOT NULL,
    CONSTRAINT season_srcid_pk PRIMARY KEY ( season_srcid )
);