 CREATE TABLE sales10 AS
 SELECT * FROM sales, ( SELECT 1 FROM dual CONNECT BY level <= 10
    ) ;

 SELECT channel_id, SUM ( amount_sold ) FROM sales10 GROUP BY
    channel_id;

DROP materialized VIEW sales_chan_amount;

CREATE materialized VIEW sales_chan_amount refresh fast ON COMMIT
AS
   SELECT channel_id, SUM ( amount_sold ) FROM sales10 GROUP BY
      channel_id;

   SELECT * FROM sales_chan_amount;

   SELECT   channel_id
    , SUM ( amount_sold )
       FROM sales10
      WHERE channel_id < 5
   GROUP BY channel_id;

  ALTER materialized VIEW sales_chan_amount enable query rewrite;

   SELECT * FROM all_objects WHERE object_name = 'SALES_CHAN_AMOUNT';

   SELECT * FROM user_mviews;

   UPDATE sales10 SET AMOUNT_SOLD = AMOUNT_SOLD * 2 WHERE rownum < 2;
  COMMIT;
  EXECUTE dbms_mview.refresh ( list=>'SALES_CHAN_AMOUNT', method=>'F'
  ) ;
  EXECUTE DBMS_MVIEW.EXPLAIN_MVIEW ( 'SALES_CHAN_AMOUNT' ) ;

   CREATE TABLE MV_CAPABILITIES_TABLE
      (
        statement_id    VARCHAR ( 30 )
      , mvowner         VARCHAR ( 30 )
      , mvname          VARCHAR ( 30 )
      , capability_name VARCHAR ( 30 )
      , possible CHARACTER ( 1 )
      , related_text VARCHAR ( 2000 )
      , related_num  NUMBER
      , msgno        INTEGER
      , msgtxt       VARCHAR ( 2000 )
      , seq          NUMBER
      ) ;

   SELECT * FROM MV_CAPABILITIES_TABLE;

  DROP MATERIALIZED VIEW LOG ON sales10;

   SELECT * FROM mlog$_sales10;
  SET serveroutput ON

  DECLARE
    l_task VARCHAR2 ( 20 ) ;
  BEGIN
    dbms_advisor.tune_mview ( l_task,
    'create materialized view sales_chan_amount
refresh fast on commit
as select channel_id,sum(amount_sold) 
from sales10
group by channel_id'
    ) ;
    dbms_output.put_line ( l_task ) ;

  END;
  /

   SELECT * FROM user_tune_mview WHERE TASK_NAME = 'TASK_711';

CREATE MATERIALIZED VIEW LOG ON "BI_LAB_TEST"."SALES10"
WITH ROWID, SEQUENCE ( "CHANNEL_ID", "AMOUNT_SOLD" ) INCLUDING NEW
    VALUES;

ALTER MATERIALIZED VIEW LOG FORCE ON "BI_LAB_TEST"."SALES10" ADD
ROWID,
SEQUENCE ( "CHANNEL_ID", "AMOUNT_SOLD" ) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW BI_LAB_TEST.SALES_CHAN_AMOUNT REFRESH FAST
WITH ROWID DISABLE QUERY REWRITE AS
 SELECT   BI_LAB_TEST.SALES10.CHANNEL_ID C1
  , SUM ( "BI_LAB_TEST"."SALES10"."AMOUNT_SOLD" ) M1
  , COUNT ( "BI_LAB_TEST"."SALES10"."AMOUNT_SOLD" ) M2
  , COUNT ( * ) M3
     FROM BI_LAB_TEST.SALES10
 GROUP BY BI_LAB_TEST.SALES10.CHANNEL_ID;

DROP MATERIALIZED VIEW BI_LAB_TEST.SALES_CHAN_AMOUNT;