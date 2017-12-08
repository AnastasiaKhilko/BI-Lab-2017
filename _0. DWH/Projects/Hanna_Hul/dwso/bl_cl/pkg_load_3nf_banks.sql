CREATE OR REPLACE PACKAGE pkg_load_3nf_banks
AS
  PROCEDURE insert_banks;
  PROCEDURE load_cls_banks;
  PROCEDURE load_ce;
END pkg_load_3nf_banks;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_banks
AS
PROCEDURE INSERT_BANKS
IS
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE wrk_banks';
  --  EXECUTE IMMEDIATE 'create table t1  as select distinct institution_name, CONCAT( ROUND(DBMS_RANDOM.VALUE(10000,99999)), UPPER( DBMS_RANDOM.STRING(a2,3))) as num_id
  --  from SA_SRC.EXT_BANKS';
  INSERT
  INTO WRK_BANKS
  SELECT  --CONCAT( ROUND(DBMS_RANDOM.VALUE(10000,99999)), UPPER( DBMS_RANDOM.STRING('A',3))) ,
    t1.num_id,
    upper(REPLACE( INSTITUTION_NAME ,'"','')),
    to_date( concat(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1,28))),concat(concat('/',TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1,12)))),concat('/', TO_CHAR(ROUND(DBMS_RANDOM.VALUE(2015,2017)))))), 'DD/MM/YYYY')
  FROM SA_SRC.EXT_BANKS s
  LEFT JOIN
    (SELECT DISTINCT upper(REPLACE( INSTITUTION_NAME ,'"',''))                                            AS bank_name,
      CONCAT( ROUND(DBMS_RANDOM.VALUE(10000,99999)), UPPER( DBMS_RANDOM.STRING('A',3))) AS num_id
    FROM SA_SRC.EXT_BANKS
    ) t1
  ON upper(REPLACE( s.INSTITUTION_NAME ,'"','')) = upper(t1.bank_name);
  --end;
  --EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_cards');
  COMMIT;
END INSERT_BANKS;
PROCEDURE load_cls_banks
IS
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_banks';
  INSERT
  INTO CLS_BANKS
    (
      bank_id,
      bank_name,
      start_dt,
      end_dt,
      is_active,
      discount,
      update_dt
    )
  SELECT bank_id,
    bank_name,
    start_dt,
    LEAD (start_dt,1,to_date('31/12/2999','DD/MM/YYYY')) OVER (PARTITION BY bank_id ORDER BY start_dt) AS end_dt,
    (
    CASE
      WHEN LEAD (start_dt,1,to_date('31/12/2999','DD/MM/YYYY')) OVER (PARTITION BY bank_id ORDER BY start_dt) = to_date('31/12/2999','DD/MM/YYYY')
      THEN 'yes'
      ELSE 'no'
    END ),
    --decode(max(DENSE_RANK() OVER (PARTITION BY bank_id ORDER BY start_dt)),'yes','no'),
    --'no',
    ROUND(DBMS_RANDOM.VALUE(0,0.5),2),
    sysdate
  FROM wrk_banks;
  commit;
END load_cls_banks;
PROCEDURE load_ce
IS
BEGIN
  MERGE INTO bl_3nf.ce_banks ce USING
  (SELECT bank_id,
    bank_name,
    start_dt,
    is_active,
    discount,
    end_dt
  FROM cls_banks
  MINUS
  SELECT bank_src_id,
    bank_name,
    start_dt,
    is_active,
    discount,
    end_dt
  FROM bl_3nf.ce_banks
  ) cls ON ( cls.bank_id = ce.bank_src_id AND cls.start_dt = ce.start_dt AND cls.end_dt = ce.end_dt )
WHEN MATCHED THEN
  UPDATE
  SET ce.bank_name = cls.bank_name,
    --  ce.start_dt =  cls.start_dt,

    ce.discount                                                                                                         = cls.discount,
    ce.update_dt                                                                                                        = sysdate
  WHERE DECODE(ce.discount,cls.discount,0,1)>0 WHEN NOT MATCHED THEN
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
      bl_3nf.seq_banks_3nf.nextval ,
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
  COMMIT;
END load_ce;
END pkg_load_3nf_banks;
/
--BEGIN
--  pkg_load_3nf_banks.insert_banks;
-- pkg_load_3nf_banks.load_cls_banks;
--  pkg_load_3nf_banks.load_ce;
--END;
--/
--select * from cls_banks where bank_id is null;