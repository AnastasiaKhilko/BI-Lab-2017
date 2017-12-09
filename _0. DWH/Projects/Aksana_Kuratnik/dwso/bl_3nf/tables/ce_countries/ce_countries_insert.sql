--CE_COUNTRIES_INSERT.
BEGIN
  pkg_etl_insert_COUNTRIES.merge_ce_countries;
END; 
/