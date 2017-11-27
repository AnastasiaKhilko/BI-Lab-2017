 SELECT   TRUNC ( time_id, 'MM' )
  , COUNT ( * )
     FROM sh.sales
 GROUP BY TRUNC ( time_id, 'MM' )
 ORDER BY 1;

DROP TABLE fct_sales;

 CREATE TABLE fct_sales partition BY range
    (
      time_id
    )
    interval
    (
      NUMTOYMINTERVAL ( 1, 'MONTH' )
    )
    (
      partition part_old VALUES less than ( to_date ( '01.01.1998',
      'dd.mm.yyyy' ) )
    ) AS
 SELECT * FROM sh.sales;

 SELECT   *
     FROM FCT_SALES
    WHERE prod_id = 13
  AND time_id     >  to_date ( '01.01.2000', 'dd.mm.yyyy' ) ;

 SELECT * FROM user_tab_partitions WHERE table_name = 'FCT_SALES';

DROP TABLE dim_products_scd;

 CREATE TABLE dim_products_scd AS
 SELECT rownum AS prod_surr_id, p.* FROM sh.products p;

 SELECT * FROM dim_products_scd;

ALTER TABLE dim_products_scd ADD ( valid_from DATE ) ;
ALTER TABLE dim_products_scd ADD ( valid_to   DATE ) ;
ALTER TABLE dim_products_scd ADD ( is_active  CHAR ( 1 ) ) ;

 UPDATE dim_products_scd
  SET valid_from = ( to_date ( '01.01.1900', 'dd.mm.yyyy' ) )
  , valid_to     = ( to_date ( '31.12.9999', 'dd.mm.yyyy' ) )
  , is_active    = 'Y';
COMMIT;

 SELECT * FROM dim_products_scd WHERE prod_id = 13;

 INSERT INTO fct.....
 SELECT   *
     FROM sh.sales s
  , dim_products_scd prd
    WHERE s.prod_id = prd.prod_id
  AND s.time_id    >= prd.valid_from
  AND s.time_id     < prd.valid_to;

 SELECT prod_id, COUNT ( * ) FROM sh.sales GROUP BY prod_id ORDER BY
    2 DESC;