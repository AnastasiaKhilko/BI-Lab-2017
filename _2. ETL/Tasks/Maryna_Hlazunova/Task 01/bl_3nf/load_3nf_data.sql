SET SERVEROUTPUT ON

BEGIN
-- Load worlds
    pkg_etl_load_3nf.load_ce_worlds;
-- Load continents
    pkg_etl_load_3nf.load_ce_continents;
-- Load regions
    pkg_etl_load_3nf.load_ce_regions;
-- Load countries
    pkg_etl_load_3nf.load_ce_countries;
END;