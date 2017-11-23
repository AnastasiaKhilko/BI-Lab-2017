EXECUTE pckg_drop.drop_proc('ext_catalog', 'table');
CREATE TABLE ext_catalog
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
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('price_full.csv')
  )
  reject limit unlimited;
/
SELECT * FROM ext_catalog
