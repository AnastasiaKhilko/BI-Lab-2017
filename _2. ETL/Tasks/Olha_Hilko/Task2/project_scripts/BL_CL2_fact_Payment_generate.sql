/*fact table generation*/
--truncate table CL_PAYMENT;
insert into CL_PAYMENT
SELECT FRAMEWORK.pkg_utl_seq.seq_getval('BL_CL2.SEQ_CL_Payment_ID_PAYMENT') ID_PAYMENT,
  case when trunc(dbms_random.value(1,10)) <=6 then 'BYN'
  when trunc(dbms_random.value(1,10)) = 7 then  'BYR'
  when trunc(dbms_random.value(1,10)) = 8 then  'USD'
  when trunc(dbms_random.value(1,10)) = 9 then  'EUR'
  when trunc(dbms_random.value(1,10)) = 10 then  'RUR'
  ELSE 'BYN'
  end  ID_CURRENCY,
  trunc(dbms_random.value(1,(SELECT MAX(ID_CUSTOMER) FROM BL_3NF2.CUSTOMER))) ID_CUSTOMER,
   case when trunc(dbms_random.value(1,10)) <=8 then  1
   ELSE 2 END ID_PAYMENT_TYPE, -- ÞÐÈÊÈ
  sysdate- trunc(dbms_random.value(1,1000)) PAYMENT_DATE,
  round(dbms_random.value(1,600),2)  PRICE,
  null PAYMENT_TIME,
  trunc(dbms_random.value(1,(SELECT MAX(ID_STATION) FROM BL_3NF2.STATION))) ID_STATION,
  null LOCATION_DECS
FROM  (select dbms_random.value(1,10) from dual connect by level <= 10000)  ;
--connect by level <= 10000;

select * from CL_PAYMENT;