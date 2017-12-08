create or replace PACKAGE pkg_etl_load_cards AS
    PROCEDURE load_cls_card_types;
    PROCEDURE load_ce_card_types;
    PROCEDURE load_cls_cards;
    PROCEDURE load_ce_cards;
END pkg_etl_load_cards;
/
create or replace PACKAGE BODY pkg_etl_load_cards AS

PROCEDURE load_cls_card_types
        IS
       -- DECLARE
        --emp_dept_id employees.department_id%TYPE;

    BEGIN
    --execute DROP SEQUENCE seq_card_types;

        EXECUTE IMMEDIATE 'truncate table cls_card_types';
    --EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_card_types START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 1000000 NOCYCLE NOCACHE ORDER';
        FOR rec IN (
        SELECT distinct CCType
          FROM wrk_customers)
   LOOP
      insert  into cls_card_types(CARD_TYPE_ID,CCType) values(seq_card_types.nextval,rec.CCType);
   END LOOP;
       
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_card_types;

PROCEDURE load_cls_cards
        IS
        begin
     execute immediate' truncate table cls_cards';
    insert  into cls_cards(CCType_id	,
      bank_id,
        
        CCNumber,
        CVV2,
        CCExpires) 
        select ce.CARD_TYPE_3nf_ID 	,
        round( dbms_random.value(1,(select count(*) from bl_3nf.ce_banks))),--?????
       CVV2 ,
        CCNumber,
        CCExpires
        from wrk_customers w left  join bl_3nf.ce_card_types ce
        on w.CCType = ce.cctype ;
       
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        

         
    END load_cls_cards;

PROCEDURE load_ce_card_types
        IS
       -- DECLARE
        --emp_dept_id employees.department_id%TYPE;

    BEGIN
    insert INTO bl_3nf.ce_card_types (SELECT CARD_TYPE_ID, CCTYPE FROM cls_card_types where cctype in (SELECT 
CCType from cls_card_types minus
SELECT 
CCType from bl_3nf.ce_card_types
));
    --execute DROP SEQUENCE seq_card_types;

        --EXECUTE IMMEDIATE 'truncate table cls_card_types';
    --EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_card_types START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 1000000 NOCYCLE NOCACHE ORDER';
        FOR rec IN (
        SELECT distinct CCType
          FROM wrk_customers)
   LOOP
      insert  into cls_card_types(CARD_TYPE_ID,CCType) values(seq_card_types.nextval,rec.CCType);
   END LOOP;
       
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        
   
    END load_ce_card_types;

PROCEDURE load_ce_cards
       IS
       begin
       insert INTO bl_3nf.ce_cards
       select seq_cards_3nf.nextval, bank_id,
          CCType_id,
         CVV2 ,
        CCNumber,
        CCExpires
         --cls.update_date
         --sysdate
from cls_cards
--MERGE INTO bl_3nf.ce_cards ce USING
--( SELECT  --source_3nf_id,
-- CCType_id,
-- bank_id,
--         CVV2 ,
--        CCNumber,
--        CCExpires
--         --update_date
--         FROM cls_cards
--MINUS
--SELECT  --source_3nf_id,
--        CCType_id,
--         bank_id,
--        CVV2 ,
--        CCNumber,
--        CCExpires
--         --update_date
--         FROM bl_3nf.ce_cards
-- )
-- cls 
--ON ( cls.CCNumber = ce.CCNumber )
--WHEN MATCHED THEN
--  UPDATE
--  SET 
--      ce.CCTYpe_id = cls.CCType_id,
-- ce.bank_id = cls.bank_id,
-- ce.CCExpires = cls.CCExpires,
--      ce.CVV2 = cls.CVV2
--    WHEN NOT MATCHED THEN
--  INSERT
--    VALUES
--    (
--         seq_cards_3nf.nextval ,
--
--          cls.bank_id,
--          cls.CCType_id,
--         cls.CVV2 ,
--        cls.CCNumber,
--        cls.CCExpires
--         --cls.update_date
--         --sysdate
--    ) ;
--    --end;
   commit;
    end load_ce_cards;

END pkg_etl_load_cards;
/
DROP SEQUENCE seq_cards_3nf;
CREATE SEQUENCE seq_cards_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

DROP SEQUENCE seq_card_types;
CREATE SEQUENCE seq_card_types_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
CREATE SEQUENCE seq_card_types START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 1000000 NOCYCLE NOCACHE ORDER;

execute pkg_etl_load_cards.load_cls_card_types;
execute pkg_etl_load_cards.load_cls_cards;
execute pkg_etl_load_cards.load_ce_cards;
execute pkg_etl_load_cards.load_ce_card_types;
commit;
select count( *) from cls_cards;
select count(distinct cctype) from cls_cards;
select distinct cctype from cls_cards;
select count() distinct from (select distinct ccnumber from cls_cards);
select * from wrk_customers;
select * from cls_cards;
select * from bl_3nf.ce_cards;
select *from bl_3nf.ce_cards;
select distinct cctype from wrk_customers;
select * from cls_card_types;