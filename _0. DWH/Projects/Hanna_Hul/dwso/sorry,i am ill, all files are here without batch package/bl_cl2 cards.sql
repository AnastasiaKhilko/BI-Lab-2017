create or replace PACKAGE pkg_load_cards_dwh AS
    PROCEDURE load_cls2_cards;
     PROCEDURE load_dwh;
END pkg_load_cards_dwh;
/
create or replace PACKAGE BODY pkg_load_cards_dwh AS
PROCEDURE load_cls2_cards
        IS


    BEGIN


        EXECUTE IMMEDIATE 'truncate table cls_cards';

      insert  into cls_cards
      select CARD_3NF_ID,
        BANK_NAME,
        start_dt,
        end_dt,
       is_active,
        discount,
        CCTYPE,
        CVV2,
        CCNUMBER,
        CCEXPIRES
        from bl_3nf.CE_CARDS ca left join bl_3nf.CE_banks b on 
        ca.bank_id = b.bank_3nf_id
        left join
        bl_3nf.CE_CARD_typeS t on 
        ca.CCTYPE_ID = t.CARD_TYPE_3NF_ID;
        
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        

    END load_cls2_cards;
PROCEDURE load_dwh
        IS


    BEGIN

       MERGE INTO BL_DWH.DWH_CARDS d USING
( SELECT  CARD_3NF_ID,
        BANK_NAME,
        start_dt,
        end_dt,
       is_active,
        discount,
        CCTYPE,
        CVV2,
        CCNUMBER,
        CCEXPIRES FROM cls_cards
MINUS
SELECT CARD_3NF_ID,
        BANK_NAME,
        start_dt,
        end_dt,
       is_active,
        discount,
        CCTYPE,
        CVV2,
        CCNUMBER,
        CCEXPIRES
FROM bl_dwh.dwh_cards
) cls 
ON ( cls.card_3nf_id = d.card_3nf_id )
WHEN MATCHED THEN
  UPDATE
  SET 
        -- d.CARD_3NF_ID = cls.CARD_3NF_ID,
        d.BANK_NAME = cls.BANK_NAME,
        d.start_dt = cls.start_dt ,
        d.end_dt = cls.end_dt,
       d.is_active = cls.is_active,
        d.discount = cls.discount,
        d.CCTYPE = cls.CCTYPE,
        d.CVV2 = cls.CVV2,
        d.CCNUMBER = cls.CCNUMBER,
        d.CCEXPIRES = cls.CCEXPIRES
    WHEN NOT MATCHED THEN
  INSERT
--    (
--
--         source_dwh_id,
--         source_3nf_id,
--         source_id,
--         Site,
--         visits,
--         Time_online,
--         Page_Views,
--         Leading_Country,
--         source_tax,
--         update_date
--          )
    VALUES
    (
         bl_dwh.seq_cards_dwh.nextval ,
          cls.card_3nf_id ,
         cls.BANK_NAME,
        cls.start_dt ,
        cls.end_dt,
       cls.is_active,
        cls.discount,
       cls.CCTYPE,
        cls.CVV2,
        cls.CCNUMBER,
        cls.CCEXPIRES--,
       --  sysdate
    ) ;
    --end;
   commit;
        --EXECUTE IMMEDIATE 'truncate table bl_dwh.dwh_cards';

      insert  into bl_dwh.dwh_cards
      select 
      bl_dwh.seq_cards_dwh.nextval,
       CARD_3NF_ID,
        BANK_NAME,
        start_dt,
        end_dt,
       is_active,
        discount,
        CCTYPE,
        CVV2,
        CCNUMBER,
        CCEXPIRES
        from cls_cards;
        
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        

    END load_dwh;
END pkg_load_cards_dwh;
/
select *from bl_3nf.CE_CARDS ;
select *from bl_3nf.CE_CARD_typeS ;
select *from bl_3nf.CE_bankS ;
select *from cls_CARDS ;
select *from cls_CARDS ;
select * from bl_dwh.dwh_cards;
exec pkg_load_cards_dwh.load_cls2_cards;
exec pkg_load_cards_dwh.load_dwh;