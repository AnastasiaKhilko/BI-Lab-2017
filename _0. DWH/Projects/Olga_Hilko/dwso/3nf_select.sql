 exec dbms_stats.gather_table_stats( 'BL_3NF', 'CE_PAYMENT', cascade=>true );
select 
 case when r.Region_name is null then 'Республика Беларусь' else r.Region_name end 
 "Название региона", ft.RUS_TYPE "Тип топлива", sum(p.price) "Выручка"
 from BL_3NF.CE_PAYMENT p
left join BL_3NF.CE_PAYMENT_Type pt on pt.ID_SEQUENCE= p.ID_PAyment_type
left join BL_3NF.CE_CUSTOMER c ON c.ID_CUSTOMER=p.ID_CUSTOMER
left join BL_3NF.CE_FUEL_Type ft on ft.ID_SEQUENCE=p.ID_FUEL_CODE
left join BL_3NF.CE_AZS a on a.ID_STATION=p.ID_STATION 
left  join  BL_3NF.CE_DISTRICT  d on d.ID_DISTRICT = a.ID_DISTRICT left JOIN BL_3NF.CE_REGION r ON  r.id_region = d.id_region
where p.PAYMENT_DATE between to_date('01/01/1995','mm/dd/yyyy') and to_date('01/01/2015','mm/dd/yyyy') 
--and c.UPDATE_DATE<to_date('11/28/2017','mm/dd/yyyy')
GROUP BY ft.RUS_TYPE , case when r.Region_name is null then 'Республика Беларусь' else r.Region_name end
order by  1,2
;

select count(*) from BL_3NF.CE_PAYMENT p;