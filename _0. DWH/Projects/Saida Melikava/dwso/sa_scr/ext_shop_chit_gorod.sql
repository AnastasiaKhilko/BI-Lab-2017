EXECUTE pckg_drop.drop_proc('ext_shop_chit_gorod', 'table');
CREATE TABLE ext_shop_chit_gorod
  (
    code         VARCHAR2 ( 200 CHAR ),
    names         VARCHAR2 ( 200 CHAR ),
    city         VARCHAR2 ( 200 CHAR ),
    street       VARCHAR2 ( 200 CHAR ),
    number_house VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('chit.csv')
  )
  reject limit unlimited;
/
SELECT * FROM ext_shop_chit_gorod
;
