-- DROPPING synonyms
execute pkg_drop.DROP_Proc ('EXT_PRODUCTS','synonym');
execute pkg_drop.DROP_Proc ('EXT_CONSUMERS','synonym');
execute pkg_drop.DROP_Proc ('EXT_DEPARTMENTS','synonym');
execute pkg_drop.DROP_Proc ('EXT_LOCATIONS','synonym');
execute pkg_drop.DROP_Proc ('EXT_PRODUCTS','synonym');
execute pkg_drop.DROP_Proc ('EXT_LOCATIONS','synonym');

-- DROPPING tables
---- wrk
execute pkg_drop.DROP_Proc('wrk_products','table');
execute pkg_drop.DROP_Proc('wrk_consumers','table');
execute pkg_drop.DROP_Proc('wrk_departments','table');
execute pkg_drop.DROP_Proc('wrk_promotions','table');
execute pkg_drop.DROP_Proc('wrk_sales','table');
execute pkg_drop.DROP_Proc('wrk_locations','table');
---- cls
execute pkg_drop.DROP_Proc('cls_products','table');
execute pkg_drop.DROP_Proc('cls_consumers','table');
execute pkg_drop.DROP_Proc('cls_departments','table');
execute pkg_drop.DROP_Proc('cls_promotions','table');
execute pkg_drop.DROP_Proc('cls_sales','table');
execute pkg_drop.DROP_Proc('cls_locations','table');
