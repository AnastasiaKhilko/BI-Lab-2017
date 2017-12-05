 create table tab_src as 
 select
 c.CUSTOMER_TYPE_DESCRIPTION "Тип покупателя", 
 a.Region_name "Назв. региона",
  ft.RUS_TYPE "Тип топлива", trunc(sum(p.price)) "Выручка"
 from BL_DM.FCTPAYMENT p
    inner join BL_DM.DIMPAYMENT_Type pt on pt.PAYMENT_TYPE_SURR_ID=p.ID_PAYMENT_TYPE
    inner join BL_DM.DIMCUSTOMER c ON c.CUSTOMER_SURR_ID=p.ID_CUSTOMER
    inner join BL_DM.DIMFUEL_Type ft on ft.FUEL_TYPE_SURR_ID=p.ID_FUEL_TYPE
    inner join BL_DM.DIMAZS a on a.AZS_SURR_ID=p.ID_STATION
    inner join BL_DM.DIMDATE d on trunc(p.PAYMENT_DATE)=d.DATE_ID

where p.PAYMENT_DATE between to_date('01/01/2005','mm/dd/yyyy') and to_date('01/01/2015','mm/dd/yyyy') 
and c.CUSTOMER_TYPE_DESCRIPTION='Юридические лица'
--and c.UPDATE_DATE<to_date('11/28/2017','mm/dd/yyyy')
GROUP BY cube(c.CUSTOMER_TYPE_DESCRIPTION, ft.RUS_TYPE ,a.Region_name)
order by  1,2,3;


create table src2 as
SELECT * FROM  (SELECT rownum as id,t."Тип покупателя" as customer_type ,t."Назв. региона" as region ,  t."Выручка"  as sales 
FROM tab_src t where "Тип топлива" is null) src
ORDER BY 1 ;

alter table src2 add constraint PK_ID Primary KEY (id);