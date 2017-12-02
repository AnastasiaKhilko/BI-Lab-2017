BEGIN
    pkg_etl_insert_wrk.insert_data(table_name_into => 'wrk_products',
                                   table_name_from => 'ext_products');
END;