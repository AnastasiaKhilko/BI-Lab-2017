create or replace PACKAGE pkg_load_dwh_sources AS
    PROCEDURE load_cls2_source;
    PROCEDURE load_dwh;
END pkg_load_dwh_sources;
/
create or replace PACKAGE BODY pkg_load_dwh_sources AS

PROCEDURE load_cls2_source
        IS


    BEGIN


        EXECUTE IMMEDIATE 'truncate table cls_sources';

      insert  into cls_sources
      select SOURCE_3NF_ID,
         SOURCE_ID,
         SITE,
         VISITS,
         TIME_ONLINE,
         PAGE_VIEWS,
         LEADING_COUNTRY,
         SOURCE_TAX,
         UPDATE_DATE
        from bl_3nf.CE_sources ;
        
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        

    END load_cls2_source;

PROCEDURE load_dwh
       IS
       begin
       MERGE INTO bl_dwh.dim_sources d USING
( SELECT  source_3nf_id,
         source_id,
         Site,
         visits,
         Time_online,
         Page_Views,
         Leading_Country ,
         source_tax,
         update_date FROM cls_sources
MINUS
SELECT  source_3nf_id,
         source_id,
         Site,
         visits,
         Time_online,
         Page_Views,
         Leading_Country ,
         source_tax,
         update_date
FROM bl_dwh.dim_sources
) cls 
ON ( cls.source_3nf_id = d.source_3nf_id )
WHEN MATCHED THEN
  UPDATE
  SET 
         d.source_id = cls.source_id ,
         d.Site = cls.site,
         d.visits = cls.visits,
         d.Time_online = cls.time_online,
         d.Page_Views = cls.Page_Views,
         d.Leading_Country = cls.Leading_Country,
         d.source_tax = cls.source_tax,
         update_date = sysdate
    WHEN NOT MATCHED THEN
  INSERT
    (

         source_dwh_id,
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
         bl_dwh.seq_source_dwh.nextval ,
         cls.source_3nf_id,
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
    end load_dwh;


END pkg_load_dwh_sources;
/

