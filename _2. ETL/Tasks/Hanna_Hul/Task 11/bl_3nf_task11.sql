explain plan for
select f.check_in_date,
      c.name,
      c.surname,
      c.age_group,
      h.hotel_name,
      s.site,
      b.bank_name,
      f.amount
  from ce_ORDERS f left join ce_customers c 
  on f.customer_id = c.customer_3nf_id
  left join ce_SOURCES s 
  on f.source_id = s.source_3nf_id
  left join ce_CARDS cc
  on f.card_id = cc.card_3nf_id
  left join ce_banks b
  on cc.bank_id = b.bank_3nf_id
  left join ce_hotels h
  on f.hotel_id = H.hotel_3nf_ID
  where f.source_id = 1
  and f.room_type = 'single';
  
select * from table(dbms_xplan.display);