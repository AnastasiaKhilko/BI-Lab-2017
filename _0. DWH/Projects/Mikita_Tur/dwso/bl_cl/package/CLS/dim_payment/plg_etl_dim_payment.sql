CREATE OR REPLACE PACKAGE pkg_etl_insert_payment
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_payment;
  PROCEDURE merge_table_payment;
						
END pkg_etl_insert_payment;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_payment
AS
---------------------------------------------------  
PROCEDURE insert_table_payment
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls2_dim_payment');
  BEGIN
  insert into CLS2_DIM_PAYMENT(payment_type,start_dt,end_dt)
  select distinct (cctype) ,
  TO_DATE('01/01/1900','DD/MM/YYYY') start_dt,
  TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
  from wrk_customers;
   insert into CLS2_DIM_PAYMENT(payment_type,start_dt,end_dt)
   values ('post_payment',TO_DATE('01/01/1900','DD/MM/YYYY'),  TO_DATE('31/12/9999','DD/MM/YYYY'));
    
      END;
  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_payment;
--------------------------------------------------- 
PROCEDURE merge_table_payment
IS
BEGIN
   merge into  bl_dm.dim_payment tgt USING
   select payment_id,payment_type,start_dt,end_dt from CLS2_DIM_PAYMENT src
   minus 
    select payment_id,payment_type,start_dt,end_dt from bl_dm.dim_payment tgt
    on (tgt.payment_type=src.payment_type)
    when matched then update set tgt.payment_id = src.payment_id,
     tgt.END_DT=src.end_dt
     when not matched then insert (payment_id,payment_type,start_dt,end_dt)
     values (bl_dm.dim_pay_seq.nextval,
     src.payment_type,
     src.start_dt,
     src.END_DT
     );
COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END merge_table_payment;
--------------------------------------------------- 
END pkg_etl_insert_payment;