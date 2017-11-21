BEGIN
  pkg_insert_to_wrk.insert_table_to_wrk(distanation_table => 'wrk_countries', source_table => 'ext_geo_countries_iso3166');
END;

BEGIN
  pkg_insert_to_wrk.insert_table_to_wrk(distanation_table => 'wrk_structure', source_table => 'ext_geo_structure_iso3166 ');
END;

BEGIN
  pkg_insert_to_wrk.insert_table_to_wrk(distanation_table => 'wrk_connection', source_table => 'ext_cntr2structure_iso3166');
END;

COMMIT;
