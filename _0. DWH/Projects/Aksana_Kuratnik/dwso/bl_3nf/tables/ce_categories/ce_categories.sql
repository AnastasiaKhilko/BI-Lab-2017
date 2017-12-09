--CE_CATEGOIES.
DROP TABLE ce_categories;
CREATE TABLE ce_categories
  (
    category_id    NUMBER ( 38 ) NOT NULL,
    category_srcid VARCHAR2 ( 200 CHAR ) NOT NULL,
    category_name  VARCHAR2 ( 200 CHAR ),
    update_dt        DATE DEFAULT SYSDATE,
    CONSTRAINT category_id_pk PRIMARY KEY ( category_id ),
    CONSTRAINT category_srcid_unq UNIQUE ( category_srcid )
  );