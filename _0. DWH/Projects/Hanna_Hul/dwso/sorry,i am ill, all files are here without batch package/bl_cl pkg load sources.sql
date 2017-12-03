create or replace PACKAGE pkg_etl_load_sources AS
    PROCEDURE load_to_wrk;
    PROCEDURE load_cls_sources;
    PROCEDURE load_ce;
END pkg_etl_load_sources;
/

create or replace PACKAGE BODY pkg_etl_load_sources AS
---------------------------------------------------  
PROCEDURE load_to_wrk
       IS
    begin
    EXECUTE IMMEDIATE 'truncate table wrk_sources';
        insert into wrk_sources select * from SA_SRC.EXT_sources;
    commit;
    end load_to_wrk;

PROCEDURE load_cls_sources
     IS
     begin
     declare
 cursor source_cur is select * from wrk_sources;
        rec source_cur%ROWTYPE;
    begin
        EXECUTE IMMEDIATE 'truncate table cls_sources';
        --if not rec%isopen then
        OPEN source_cur;
      --  end if;
        loop
            FETCH source_cur into rec;
            exit when source_cur%notfound;
            
       insert into CLS_sources(
        --source_3nf_id,
         source_id,
         Site,
         visits,
         Time_online,
         Page_Views,
         Leading_Country ,
         source_tax,
         update_date)
         values (
         --seq_sources_3nf.nextval ,
         --1, 
         --to_number(rec.source_id) ,
         to_number(rec.source_id) ,
         rec.Site ,
         to_number(replace(rec.visits,'Million')),
         rec.Time_online,
         to_number(rec.Page_Views),
         rec.Leading_Country,
         round(abs(dbms_random.normal*2 + 5),2),
         sysdate
         );
         end loop;
         close source_cur;
         end;
commit;
end load_cls_sources;

PROCEDURE load_ce
       IS
       begin
       MERGE INTO bl_3nf.ce_sources ce USING
( SELECT  --source_3nf_id,
         source_id,
         Site,
         visits,
         Time_online,
         Page_Views,
         Leading_Country ,
         source_tax,
         update_date FROM cls_sources
MINUS
SELECT  --source_3nf_id,
         source_id,
         Site,
         visits,
         Time_online,
         Page_Views,
         Leading_Country ,
         source_tax,
         update_date
FROM bl_3nf.ce_sources
) cls 
ON ( cls.source_id= ce.source_id )
WHEN MATCHED THEN
  UPDATE
  SET 
         --ce.source_id = cls.source_id ,
         ce.Site = cls.site,
         ce.visits = cls.visits,
         ce.Time_online = cls.time_online,
         ce.Page_Views = cls.Page_Views,
         ce.Leading_Country = cls.Leading_Country,
         ce.source_tax = cls.source_tax,
         update_date = sysdate
    WHEN NOT MATCHED THEN
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
         seq_sources_3nf.nextval ,
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
   commit;
    end load_ce;

END pkg_etl_load_sources;
/

DROP SEQUENCE seq_sources_3nf;
CREATE SEQUENCE seq_sources_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

begin        
pkg_etl_load_sources.load_to_wrk;
pkg_etl_load_sources.load_cls_sources;
pkg_etl_load_sources.load_ce;
end;
/
select *from wrk_sources;
select * from cls_sources;