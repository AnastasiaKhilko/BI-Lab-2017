 exec dbms_stats.gather_table_stats( 'BL_DM', 'FCTPAYMENT', cascade=>true );
select 
 a.Region_name "Назв. региона",
  ft.RUS_TYPE "Тип топлива", sum(p.price) "Выручка"
 from BL_DM.FCTPAYMENT p
    left join BL_DM.DIMPAYMENT_Type pt on pt.PAYMENT_TYPE_SURR_ID=p.ID_PAYMENT_TYPE
    left join BL_DM.DIMCUSTOMER c ON c.CUSTOMER_SURR_ID=p.ID_CUSTOMER
    left join BL_DM.DIMFUEL_Type ft on ft.FUEL_TYPE_SURR_ID=p.ID_FUEL_TYPE
    left join BL_DM.DIMAZS a on a.AZS_SURR_ID=p.ID_STATION
   -- left join BL_DM.DIMDATE d on trunc(p.PAYMENT_DATE)=d.DATE_ID
--left  join  BL_DM.CE_DISTRICT  d on d.ID_DISTRICT = a.ID_DISTRICT 
--INNER JOIN BL_3NF.CE_REGION r ON  r.id_region = d.id_region
where p.PAYMENT_DATE between to_date('01/01/1995','mm/dd/yyyy') and to_date('01/01/2015','mm/dd/yyyy') 
--and c.UPDATE_DATE<to_date('11/28/2017','mm/dd/yyyy')
GROUP BY ft.RUS_TYPE ,a.Region_name
order by  1,2

;
select count (*) from BL_DM.FCTPAYMENT;