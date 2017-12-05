 exec dbms_stats.gather_table_stats( 'BL_DM', 'FCTPAYMENT', cascade=>true );
 EXPLAIN PLAN FOR
SELECT --+ PARALLEL(p, 4) 
 a.Region_name "Назв. региона",
  ft.RUS_TYPE "Тип топлива", sum(p.price) "Выручка"
 from BL_DM.FCTPAYMENT p
    left join BL_DM.DIMPAYMENT_Type pt on pt.PAYMENT_TYPE_SURR_ID=p.ID_PAYMENT_TYPE
    left join BL_DM.DIMCUSTOMER c ON c.CUSTOMER_SURR_ID=p.ID_CUSTOMER
    left join BL_DM.DIMFUEL_Type ft on ft.FUEL_TYPE_SURR_ID=p.ID_FUEL_TYPE
    left join BL_DM.DIMAZS a on a.AZS_SURR_ID=p.ID_STATION
where p.PAYMENT_DATE between to_date('01/01/1995','mm/dd/yyyy') and to_date('01/01/2015','mm/dd/yyyy') 
GROUP BY ft.RUS_TYPE ,a.Region_name
order by  1,2;

SELECT * FROM TABLE (dbms_xplan.display);
select count (*) from BL_DM.FCTPAYMENT;