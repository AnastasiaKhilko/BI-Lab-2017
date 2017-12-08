CREATE OR REPLACE PACKAGE pkg_load_3nf_categories
AS
  PROCEDURE load_wrk_categories;
  PROCEDURE load_cls_categories;
  PROCEDURE load_ce;
END pkg_load_3nf_categories;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_categories
AS
PROCEDURE load_wrk_categories
IS
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE wrk_categories';
  INSERT
  INTO WRK_categories
  SELECT 
    category_name,
    min_star,
    max_star,
    to_date( concat(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1,28))),
    concat(concat('/',TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1,12)))),
    concat('/', TO_CHAR(ROUND(DBMS_RANDOM.VALUE(2015,2017)))))), 'DD/MM/YYYY') as start_dt
  FROM SA_SRC.EXT_categories
  COMMIT;
END load_wrk_categories;
PROCEDURE load_cls_categories
IS
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_categories';
  INSERT
  INTO CLS_categories
    (
      category_name,
      min_star,
      max_star,
      start_dt,
      end_dt,
      is_active,
      update_dt
    )
  SELECT 
    category_name,
    nvl(min_star,-99),
    nvl(max_star,-99),
    start_dt,
    LEAD (start_dt,1,to_date('31/12/2999','DD/MM/YYYY')) OVER (PARTITION BY category_name ORDER BY start_dt) AS end_dt,
    (
    CASE
      WHEN LEAD (start_dt,1,to_date('31/12/2999','DD/MM/YYYY')) OVER (PARTITION BY category_name ORDER BY start_dt) = to_date('31/12/2999','DD/MM/YYYY')
      THEN 'yes'
      ELSE 'no'
    END ),
    sysdate
  FROM wrk_categories;
  commit;
END load_cls_categories;
PROCEDURE load_ce
IS
BEGIN
  MERGE INTO bl_3nf.ce_categories ce USING
  (SELECT category_name,
      min_star,
      max_star,
      start_dt,
      end_dt,
      is_active,
      update_dt
  FROM cls_categories
  MINUS
  SELECT category_name,
      min_star,
      max_star,
      start_dt,
      end_dt,
      is_active,
      update_dt
  FROM bl_3nf.ce_categories
  ) cls ON ( cls.category_name = ce.category_name AND cls.start_dt = ce.start_dt AND cls.end_dt = ce.end_dt )
WHEN MATCHED THEN
  UPDATE
  SET ce.min_star = cls.min_star,
      ce.max_star = cls.max_star,
      ce.is_active =  cls.is_active,
      ce.update_dt = sysdate
  WHERE  ( DECODE( ce.min_star, cls.min_star, 0, 1 ) + 
  DECODE( ce.max_star, cls.max_star, 0, 1 ) ) > 0 
  WHEN NOT MATCHED THEN
  INSERT
    VALUES
    (
      bl_3nf.seq_categories_3nf.nextval ,
      cls.category_name,
      cls.min_star,
      cls.max_star,
      cls.start_dt,
      cls.end_dt,
      cls.is_active,
      sysdate
    ) ;
  --end;
  COMMIT;
END load_ce;
END pkg_load_3nf_categories;
/
--BEGIN
--  pkg_load_3nf_categories.load_wrk_categories;
-- pkg_load_3nf_categories.load_cls_categories;
--  pkg_load_3nf_categories.load_ce;
--END;
--/
--select * from cls_categories where bank_id is null;