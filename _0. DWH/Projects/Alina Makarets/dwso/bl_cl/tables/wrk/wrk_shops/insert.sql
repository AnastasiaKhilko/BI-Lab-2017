BEGIN
    pkg_etl_insert_wrk.insert_data(table_name_into => 'wrk_shops',
                                   table_name_from => 'ext_shops');
END;