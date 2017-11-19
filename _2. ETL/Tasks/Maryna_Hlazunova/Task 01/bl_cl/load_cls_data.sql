SET SERVEROUTPUT ON

BEGIN
-- Load 
    pkg_etl_load_cls.load_cls_structure;
-- Load 
    pkg_etl_load_cls.load_cls_countries;  
-- Load 
    pkg_etl_load_cls.load_cls_countries_reg;
END;