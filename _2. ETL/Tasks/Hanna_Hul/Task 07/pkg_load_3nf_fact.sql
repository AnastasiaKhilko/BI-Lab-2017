CREATE OR REPLACE PACKAGE pkg_load_3nf_fact
AS
  PROCEDURE generate_fact;
  PROCEDURE load_fact;
END pkg_load_3nf_fact;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_fact
AS
PROCEDURE generate_fact
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_orders';
  INSERT INTO cls_orders
  SELECT greatest(least(ABS(ROUND(DBMS_RANDOM.normal*8000 + DBMS_RANDOM.normal*1000 +
  DBMS_RANDOM.normal*100 + 500)),( SELECT COUNT ( * ) FROM bl_3nf.ce_customers
    )),1),
    TRUNC ( sysdate                  + dbms_random.value ( -1500, 1500 ) ),
    least (ROUND ( ABS ( dbms_random.normal *
    ( SELECT COUNT ( * ) FROM bl_3nf.ce_hotels
    ) /20) + dbms_random.value ( 0.51,
    ( SELECT COUNT ( * ) FROM bl_3nf.ce_hotels
    ) /5 ) ), (select count(*) from bl_3nf.ce_hotels ) ) AS hotel_id,
    greatest(least(ROUND ( ABS ( dbms_random.normal *
    ( SELECT COUNT ( * ) FROM bl_3nf.ce_sources
    ) /10 +
    ( SELECT COUNT ( * ) FROM bl_3nf.ce_sources
    )                                                  *1/4 ) ),
    ( SELECT COUNT ( * ) FROM bl_3nf.ce_sources) ), 1) AS source_id,
    least ( greatest(ROUND(sqrt( ABS(dbms_random.normal*2000-300))),1),
    (SELECT COUNT(*) FROM bl_3nf.ce_cards) ) AS card_id,
    TRUNC ( sysdate                          + dbms_random.value ( -1500, 1500 ) ),
    ROUND(sqrt( ABS(dbms_random.normal)*3 + 1)),
    ROUND(ABS( dbms_random.value ( 70, 800 ) + dbms_random.normal*90 ) ) AS amount,
    --greatest(ROUND ( abs(dbms_random.value)*2),1),
    (case when dbms_random.value < 0.25 then 'single'
          when dbms_random.value < 0.7 then 'double'
          when dbms_random.value < 0.9 then 'twin room'
          when dbms_random.value < 0.95 then 'duplex'
          else 'studio'
    end),
      
    greatest(ROUND ( dbms_random.normal             + ROUND(dbms_random.value ( 0,5 )) ), 1),
    ROUND( greatest( ( dbms_random.value ( 0.01, 10.49 ) - dbms_random.value ( 0.01, 8.49 ) ), 0 ), 2 )
  FROM dual
    CONNECT BY level <= 1000000;
  COMMIT;
END generate_fact;
PROCEDURE load_fact
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_orders';
  --EXECUTE IMMEDIATE ' exec sys.do_truncate';
  INSERT
  INTO bl_3nf.ce_orders
    (
      customer_id ,
      order_date ,
      hotel_id ,
      source_id ,
      card_id,
      check_in_date ,
      days_amount,
      amount ,
      room_type ,
      --class
      number_of_people ,
      discount
    )
  SELECT * FROM cls_orders;
  COMMIT;
END load_fact;
END pkg_load_3nf_fact;
/
