BEGIN
  pkg_drop.drop_proc(object_name => 'ce_collections', object_type => 'table');
END;

CREATE TABLE ce_collections
  (
    collection_id    NUMBER ( 38 ) NOT NULL,
    collection_srcid NUMBER ( 38 ) NOT NULL,
    collection_desc  VARCHAR2 ( 200 CHAR ) NOT NULL,
    start_dt         DATE DEFAULT '01-JAN-1990',
    end_dt           DATE DEFAULT '31-DEC-9999',
    is_active        VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT collection_id_pk PRIMARY KEY ( collection_id ),
    CONSTRAINT collection_srcid_unq UNIQUE ( collection_srcid )
  );