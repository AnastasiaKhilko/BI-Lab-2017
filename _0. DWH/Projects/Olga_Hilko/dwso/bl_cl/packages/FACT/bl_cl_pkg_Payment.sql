--FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_PAYMENT');
--PKG_FACT_PAYMENT.Generate;
--PKG_FACT_PAYMENT.CL_TO_3NF;


CREATE OR REPLACE PACKAGE PKG_FACT_PAYMENT AS 
PROCEDURE Generate;
PROCEDURE CL_TO_3NF;
end PKG_FACT_PAYMENT;
/

create or replace PACKAGE BODY PKG_FACT_PAYMENT as --PKG_WRK_TO_CL_CUST.WRK_TO_CL_Indiv
procedure Generate is
begin
  FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_PAYMENT');
--select max(PAYMENT_DATE),min(PAYMENT_DATE) from (
  INSERT INTO CL_PAYMENT  (    ID_PAYMENT,    ID_CUSTOMER,    ID_PAYMENT_TYPE,    ID_STATION,    ID_FUEL_CODE,    PAYMENT_DATE,
    PRICE,      PAYMENT_TIME , QUANTITY    )
  SELECT 
  1,--ID_PAYMENT, 
   trunc(dbms_random.value((SELECT min(ID_CUSTOMER) FROM BL_3NF.CE_CUSTOMER),(SELECT MAX(ID_CUSTOMER) FROM BL_3NF.CE_CUSTOMER)))ID_CUSTOMER ,
   case when trunc(dbms_random.value(1,10)) <=4 then  (SELECT min(ID_SEQUENCE) FROM BL_3NF.CE_PAYMENT_TYPE)
        when trunc(dbms_random.value(1,10)) <=3 then  (SELECT max(ID_SEQUENCE) FROM BL_3NF.CE_PAYMENT_TYPE)  
        ELSE (SELECT max(ID_SEQUENCE)-min(ID_SEQUENCE) FROM BL_3NF.CE_PAYMENT_TYPE)
   END ID_SEQUENCE_PAYMENT_TYPE,
   trunc(dbms_random.value((SELECT min(ID_STATION) FROM BL_3NF.CE_AZS),(SELECT MAX(ID_STATION) FROM BL_3NF.CE_AZS))) ID_STATION,
   (case 
    when trunc(dbms_random.value(1,(SELECT MAX(ID_SEQUENCE) FROM BL_3NF.CE_FUEL_TYPE))) < 3 then 1
    when trunc(dbms_random.value(1,(SELECT MAX(ID_SEQUENCE) FROM BL_3NF.CE_FUEL_TYPE))) < 4 then  2
    when trunc(dbms_random.value(1,(SELECT MAX(ID_SEQUENCE) FROM BL_3NF.CE_FUEL_TYPE))) < 4 then  3
    when trunc(dbms_random.value(1,(SELECT MAX(ID_SEQUENCE) FROM BL_3NF.CE_FUEL_TYPE))) < 5 then  4
    when trunc(dbms_random.value(1,(SELECT MAX(ID_SEQUENCE) FROM BL_3NF.CE_FUEL_TYPE))) < 5 then  5
    when trunc(dbms_random.value(1,(SELECT MAX(ID_SEQUENCE) FROM BL_3NF.CE_FUEL_TYPE))) < 5 then  6
    ELSE 7--(select MAX(ID_SEQUENCE) FROM BL_3NF.CE_FUEL_TYPE)
    END)+(SELECT MIN(ID_SEQUENCE) FROM BL_3NF.CE_FUEL_TYPE) ID_SEQUENCE_FUEL_TYPE,
  
   (SELECT min(DATE_ID) DATE_ID FROM BL_DM.DIMDATE)+trunc(dbms_random.value(1,(SELECT count(*)-4800 DATE_ID FROM BL_DM.DIMDATE)))   PAYMENT_DATE,
   TRUNC(DBMS_RANDOM.NORMAL*5,2)+25   PRICE,
  
   mod(to_char(sysdate,'hh') + 
    TRUNC(DBMS_RANDOM.VALUE(1,100)),24)||':'||mod(to_char(sysdate,'mi') + 
    TRUNC(DBMS_RANDOM.VALUE(1,100)),60)||':'||mod(to_char(sysdate,'ss') + 
    TRUNC(DBMS_RANDOM.VALUE(1,100)),60)  PAYMENT_TIME,
  
    1 QUANTITY
  
    FROM  (select dbms_random.value(1,10) from dual connect by level <= 1000000) ;
--rollback;

 EXCEPTION
 WHEN OTHERS THEN
  RAISE;
end Generate;
procedure CL_TO_3NF is
begin
    insert into BL_3NF.CE_PAYMENT  (    ID_PAYMENT,    ID_CUSTOMER,    ID_PAYMENT_TYPE,    ID_STATION,
        ID_FUEL_CODE,    PAYMENT_DATE,    PRICE,     PAYMENT_TIME, QUANTITY  )
    select FRAMEWORK.PKG_UTL_SEQ.seq_getval('BL_3NF.SEQ_CE_Payment_Type_ID'),
        ID_CUSTOMER,    ID_PAYMENT_TYPE,    ID_STATION,    ID_FUEL_CODE,    PAYMENT_DATE,
        PRICE,      PAYMENT_TIME , QUANTITY    from CL_PAYMENT p;
 EXCEPTION
 WHEN OTHERS THEN
  RAISE;
end CL_TO_3NF;
END PKG_FACT_PAYMENT;
/