explain plan for
select f.check_in_date,
      c.name,
      c.surname,
      c.age_group,
      h.hotel_name,
      s.site,
      b.bank_name,
      f.amount
  from FCT_ORDERS f left join dim_customers c 
  on f.customer_id = c.customer_dwh_id
  left join DIM_SOURCES s 
  on f.source_id = s.source_dwh_id
  left join DIM_CARDS b
  on f.card_id = b.card_dwh_id
  left join DIM_hotels h
  on f.hotel_id = H.hotel_DWH_ID
  where f.source_id = 1
  and f.room_type = 'single';
  
select * from table(dbms_xplan.display);