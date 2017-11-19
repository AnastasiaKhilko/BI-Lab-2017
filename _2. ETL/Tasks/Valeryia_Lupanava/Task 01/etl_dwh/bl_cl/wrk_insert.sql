BEGIN
  pkg_etl_insert.insert_table(table_name_to => 'WRK_COUNTRIES', table_name_from => 'SA_CN');
END;

BEGIN
  pkg_etl_insert.insert_table(table_name_to => 'WRK_STRUCTURES', table_name_from => 'SA_CS');
END;

BEGIN
  pkg_etl_insert.insert_table(table_name_to => 'WRK_FULL_DATA', table_name_from => 'SA_FD');
END;

COMMIT;