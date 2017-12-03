EXECUTE pckg_drop.drop_proc(object_name=>'wrk_catalog_print', object_type=>'table');
CREATE TABLE wrk_catalog_print
  (
    code             NUMBER(8),
    quantity         NUMBER(8),
    book_name        VARCHAR2 ( 200 CHAR ),
    author_name      VARCHAR2 ( 200 CHAR ),
    ISBN             VARCHAR2 ( 200 CHAR ),
    weight           VARCHAR2 ( 200 CHAR ),
    description      VARCHAR2 ( 200 CHAR ),
    genre            VARCHAR2 ( 200 CHAR ),
    links            VARCHAR2 ( 200 CHAR ),
    price            VARCHAR2 ( 200 CHAR ),
    disc_price       VARCHAR2 ( 200 CHAR ),
    corp_disc_price  VARCHAR2 ( 200 CHAR ),
    final_disc_price VARCHAR2 ( 200 CHAR ),
    price_amount     VARCHAR2 ( 200 CHAR )
  );