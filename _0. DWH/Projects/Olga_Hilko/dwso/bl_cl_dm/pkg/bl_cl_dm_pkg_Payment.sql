--FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_PAYMENT');
--PKG_FACT_PAYMENT.Generate;
--PKG_FACT_PAYMENT.CL_TO_3NF;

--PKG_FACT_PAYMENT.FACT_3NF_TO_DM
CREATE OR REPLACE PACKAGE PKG_FACT_PAYMENT AS 
PROCEDURE FACT_3NF_TO_DM;
end PKG_FACT_PAYMENT;
/

create or replace PACKAGE BODY PKG_FACT_PAYMENT as --PKG_WRK_TO_CL_CUST.WRK_TO_CL_Indiv
procedure FACT_3NF_TO_DM is
 sql_stat varchar(400);
     before_cnt NUMBER;
     after_cnt NUMBER;
     table_name varchar(100):='BL_DM.FCTPAYMENT';
begin
     before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
    insert into BL_DM.FCTPAYMENT  (   ID_PAYMENT,   
        ID_CUSTOMER,    ID_PAYMENT_TYPE,    ID_STATION,
        ID_FUEL_TYPE,    PAYMENT_DATE,    PRICE,     PAYMENT_TIME, QUANTITY  )
    select p.ID_PAYMENT,   c.CUSTOMER_SURR_ID,    pt.PAYMENT_TYPE_SURR_ID,    a.AZS_SURR_ID,    ft.FUEL_TYPE_SURR_ID,    d.DATE_ID,
       PRICE,      PAYMENT_TIME , QUANTITY     
    from    BL_3NF.CE_Payment p    
    left join BL_DM.DIMPAYMENT_Type pt on pt.ID3NF=p.ID_PAYMENT_TYPE
    left join BL_DM.DIMCUSTOMER c ON c.ID3NF=p.ID_CUSTOMER
    left join BL_DM.DIMFUEL_Type ft on ft.ID3NF=p.ID_FUEL_CODE
    left join BL_DM.DIMAZS a on a.ID3NF=p.ID_STATION
    left join BL_DM.DIMDATE d on trunc(p.PAYMENT_DATE)=d.DATE_ID;
       after_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
   dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');  
 EXCEPTION
 WHEN OTHERS THEN
  RAISE;
end FACT_3NF_TO_DM;
END PKG_FACT_PAYMENT;
/