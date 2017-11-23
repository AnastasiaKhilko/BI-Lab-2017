EXECUTE pckg_drop.drop_proc('ext_shop_nov_knizh', 'table');
CREATE TABLE ext_shop_nov_knizh
  (
    code         VARCHAR2 ( 200 CHAR ),
  subway         VARCHAR2 ( 200 CHAR ),
    address        VARCHAR2 ( 200 CHAR ),
    house       VARCHAR2 ( 200 CHAR ),
    store VARCHAR2 ( 200 CHAR ),
    lala VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('new_ch_gorod.csv')
  )
  reject limit unlimited;
/
SELECT * FROM ext_shop_nov_knizh
;
