BEGIN
  pkg_drop.drop_proc(object_name => 'ce_lines', object_type => 'table');
END;

CREATE TABLE ce_lines
  (
    line_id          NUMBER(10) NOT NULL,
    line_srcid       NUMBER(10) NOT NULL,
    line_desc        VARCHAR2(50 BYTE) NOT NULL,
    collection_srcid NUMBER(10) NOT NULL,
    start_dt         DATE DEFAULT '01-JAN-1990',
    end_dt           DATE DEFAULT '31-DEC-9999',
    is_active        VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT line_id_pk PRIMARY KEY ( line_id ),
    CONSTRAINT line_srcid_unq UNIQUE ( line_srcid ),
    CONSTRAINT collection_srcid_fk FOREIGN KEY ( collection_srcid ) 
    REFERENCES ce_collections ( collection_srcid )
  );
  