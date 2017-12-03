create or replace PACKAGE pkg_etl_load_banks AS
    PROCEDURE insert_banks;
    PROCEDURE load_cls_banks;
    PROCEDURE load_ce;
END pkg_etl_load_banks;
/

create or replace PACKAGE BODY PKG_ETL_LOAD_BANKS
AS
  ---------------------------------------------------
PROCEDURE INSERT_BANKS
IS
BEGIN


  EXECUTE IMMEDIATE 'TRUNCATE TABLE wrk_banks';
--  EXECUTE IMMEDIATE 'create table t1  as select distinct institution_name, CONCAT( ROUND(DBMS_RANDOM.VALUE(10000,99999)), UPPER( DBMS_RANDOM.STRING(a2,3))) as num_id
--  from SA_SRC.EXT_BANKS';
  
  INSERT INTO WRK_BANKS
  SELECT -- CONCAT( ROUND(DBMS_RANDOM.VALUE(10000,99999)), UPPER( DBMS_RANDOM.STRING('A',3))) ,
  num_id,
  REPLACE( INSTITUTION_NAME ,'"',''),
  to_date( concat(to_char(ROUND(DBMS_RANDOM.VALUE(1,28))),concat(concat('/',to_char(ROUND(DBMS_RANDOM.VALUE(1,12)))),concat('/',
   to_char(ROUND(DBMS_RANDOM.VALUE(2015,2017)))))),
     'DD/MM/YYYY')
  FROM SA_SRC.EXT_BANKS s left join (select distinct upper(institution_name) as bank_name,
  CONCAT( ROUND(DBMS_RANDOM.VALUE(10000,99999)), UPPER( DBMS_RANDOM.STRING('A',3))) as num_id
  from SA_SRC.EXT_BANKS) t1 on upper(s.institution_name) = upper(t1.bank_name);
--end;

  --EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_cards');
  
COMMIT;

END INSERT_BANKS;
PROCEDURE load_cls_banks
        IS
        begin
EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_banks';
insert into CLS_BANKS(bank_id,
bank_name,
start_dt,
end_dt,is_active,
discount, update_dt) 
       select bank_id,
       bank_name,
       start_dt,
      LEAD (start_dt,1,to_date('31/12/2999','DD/MM/YYYY')) OVER (PARTITION BY bank_id ORDER BY start_dt) AS end_dt,
       (case when  LEAD (start_dt,1,to_date('31/12/2999','DD/MM/YYYY')) OVER (PARTITION BY bank_id ORDER BY start_dt) =  to_date('31/12/2999','DD/MM/YYYY') then 'yes'
       else 'no'
       end ),

--decode(max(DENSE_RANK() OVER (PARTITION BY bank_id ORDER BY start_dt)),'yes','no'),
--'no',
      ROUND(DBMS_RANDOM.VALUE(0,0.5),2),
      sysdate
 from wrk_banks;
   
    END load_cls_banks;

PROCEDURE load_ce
      IS
     begin
MERGE INTO bl_3nf.ce_banks ce USING
( SELECT  bank_id,
      bank_name,
      start_dt,
     is_active,
      discount,
      end_dt
FROM cls_banks
MINUS
SELECT  bank_src_id,
      bank_name,
      start_dt,
      is_active,
      discount,
     end_dt
         FROM bl_3nf.ce_banks
 )
 cls 
ON ( cls.bank_id = ce.bank_src_id and cls.start_dt = ce.start_dt)

WHEN MATCHED THEN
  UPDATE
  SET 
       ce.bank_name = cls.bank_name,
     --  ce.start_dt =  cls.start_dt,
         ce.end_dt = cls.end_dt,
         ce.is_active = cls.is_active,
         ce.discount = cls.discount,
       ce.update_dt = sysdate
    where decode(ce.discount,cls.discount,0,1) + decode(ce.end_dt,cls.end_dt,0,1) + decode(ce.is_active,cls.is_active,0,1)>0
    WHEN NOT MATCHED THEN
  INSERT
    (
         bank_3nf_id,
         bank_src_id,
         bank_name,
         start_dt,
         end_dt,
         is_active,
         discount,
         update_dt
    )
    VALUES
    (
         seq_banks_3nf.nextval ,
         cls.bank_id,
         cls.bank_name,
         cls.start_dt,
         cls.end_dt,
         cls.is_active,
         cls.discount,
         sysdate
         --cls.update_dt
    ) ;
    --end;
 commit;
end load_ce;

END pkg_etl_load_banks;
/
select*from bl_3nf.ce_banks;
select * from  cls_banks;
select * from  wrk_banks;
DROP SEQUENCE seq_banks_3nf;
CREATE SEQUENCE seq_banks_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

begin
pkg_etl_load_banks.insert_banks;
pkg_etl_load_banks.load_cls_banks;
pkg_etl_load_banks.load_ce;
end;
/