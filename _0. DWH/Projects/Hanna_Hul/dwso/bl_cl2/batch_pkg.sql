exec pkg_load_dwh_sources.load_cls2_source;
exec pkg_load_dwh_sources.load_dwh;
EXEC pkg_load_dwh_hotels.load_cls2_hotel;
EXEC pkg_load_dwh_hotels.load_dwh;
exec pkg_load_date.generate_date;
exec bl_dwh.truncate_fact_dwh;
--exec bl_dwh.do_truncate;
exec pkg_load_date.load_date;
EXEC pkg_load_dwh_customers.load_cls2_cust;
EXEC pkg_load_dwh_customers.load_dwh;
EXEC pkg_load_dwh_cards.load_cls2_cards;
EXEC pkg_load_dwh_cards.load_dwh;
EXEC pkg_load_fact.cls_fact;
exec bl_dwh.truncate_fact_dwh;
EXEC pkg_load_fact.dwh_fact;