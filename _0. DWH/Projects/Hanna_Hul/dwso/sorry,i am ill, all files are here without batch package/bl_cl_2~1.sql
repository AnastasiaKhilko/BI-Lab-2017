create or replace PACKAGE pkg_load_cards_dwh AS
    PROCEDURE load_cls2_cards;
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
END pkg_load_cards_dwh;
/
select *from bl_3nf.CE_CARDS ;
select *from bl_3nf.CE_CARD_typeS ;
select *from bl_3nf.CE_bankS ;
select *from cls_CARDS ;
exec pkg_load_cards_dwh.load_cls2_cards;