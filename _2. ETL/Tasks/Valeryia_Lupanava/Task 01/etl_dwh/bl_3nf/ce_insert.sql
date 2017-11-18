BEGIN
  pkg_etl_insert_cntn.insert_table_continents;
END;

BEGIN
  pkg_etl_insert_cntn.insert_table_regions;
END;

BEGIN
  pkg_etl_insert_cntn.insert_table_countries;
END;

COMMIT;


