CREATE OR REPLACE PACKAGE pkg_load_3nf_sources
AS
  PROCEDURE load_to_wrk;
  PROCEDURE load_cls_sources;
  PROCEDURE load_ce;
END pkg_load_3nf_sources;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_sources
AS
  ---------------------------------------------------
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_sources';
  INSERT INTO wrk_sources
  SELECT * FROM SA_SRC.EXT_sources;
  COMMIT;
END load_to_wrk;

PROCEDURE load_cls_sources
IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cls_sources';
    
      INSERT
      INTO CLS_sources
        (
          --source_3nf_id,
          source_id,
          Site,
          visits,
          Time_online,
          Page_Views,
          Leading_Country ,
          source_tax,
          update_date
        )
        select
         --seq_sources_3nf.nextval ,
          --1,
          --to_number(rec.source_id) ,
          to_number(source_id) ,
          Site ,
          to_number(REPLACE(visits,'Million')),
          Time_online,
          to_number(Page_Views),
          upper(translate(leading_country,'1234567890%.',' ')),
          ROUND(ABS(dbms_random.normal*2 + 5),2),
          sysdate
          from wrk_sources
         ;


  COMMIT;
END load_cls_sources;
PROCEDURE load_ce
IS
BEGIN
  MERGE INTO bl_3nf.ce_sources ce USING
  (SELECT --source_3nf_id,
      source_id,
      Site,
      visits,
      Time_online,
      Page_Views,
      Leading_Country ,
      source_tax,
      update_date
    FROM cls_sources
    MINUS
    SELECT --source_3nf_id,
      source_id,
      Site,
      visits,
      Time_online,
      Page_Views,
      Leading_Country ,
      source_tax,
      update_date
    FROM bl_3nf.ce_sources
  )
  cls ON ( cls.source_id= ce.source_id )
WHEN MATCHED THEN
  UPDATE
  SET
    --ce.source_id = cls.source_id ,
    ce.Site            = cls.site,
    ce.visits          = cls.visits,
    ce.Time_online     = cls.time_online,
    ce.Page_Views      = cls.Page_Views,
    ce.Leading_Country = cls.Leading_Country,
    ce.source_tax      = cls.source_tax,
    update_date        = sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      source_3nf_id,
      source_id,
      Site,
      visits,
      Time_online,
      Page_Views,
      Leading_Country,
      source_tax,
      update_date
    )
    VALUES
    (
      bl_3nf.seq_sources_3nf.nextval ,
      cls.source_id,
      cls.Site,
      cls.visits,
      cls.Time_online,
      cls.Page_Views,
      cls.Leading_Country,
      cls.source_tax,
      cls.update_date
    ) ;
  --end;
  COMMIT;
END load_ce;
END pkg_load_3nf_sources;
/
select * from bl_3nf.ce_sources;