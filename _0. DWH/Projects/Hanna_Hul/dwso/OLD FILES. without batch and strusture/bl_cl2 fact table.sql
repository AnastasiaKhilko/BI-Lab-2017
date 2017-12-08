create or replace PACKAGE pkg_load_fact AS
    PROCEDURE cls_fact;
    PROCEDURE dwh_fact;
END pkg_load_fact;
/
create or replace PACKAGE BODY pkg_load_fact AS
PROCEDURE cls_fact
        IS


    BEGIN


        EXECUTE IMMEDIATE 'truncate table cls_orders';
insert into cls_orders select 
customer_dwh_id,
          order_date,
          
          h.source_dwh_id,
          s.source_dwh_id,
          check_in_date,
          c.days_amount,
          c.amount,
          room_type ,
          --class
          number_of_people,
          c.discount
          from bl_3nf.ce_orders c  left join BL_DWH.DWH_CUSTOMERS cc
          on c.customer_id = cc.customer_3nf_id
          left join bl_dwh.dwh_sources s
          on c.source_id = s.source_3nf_id
          left join bl_dwh.dwh_hotels h on
          c.hotel_id = h.hotel_3nf_id
          left join bl_dwh.dim_date d on 
          c.order_date = d.date_id and c.check_in_date = d.date_id ;
          
    commit;
 end  cls_fact;




PROCEDURE dwh_fact
        IS


    BEGIN


       insert into bl_dwh.fact_orders
       select *
       from
       cls_orders;
        
    commit;
 end  dwh_fact;
 end pkg_load_fact;
 
 /
 select * from cls_orders;
 select * from bl_3nf.ce_orders;
 exec pkg_load_fact.cls_fact;
exec bl_dwh.do_fact_truncate;
 exec pkg_load_fact.dwh_fact;