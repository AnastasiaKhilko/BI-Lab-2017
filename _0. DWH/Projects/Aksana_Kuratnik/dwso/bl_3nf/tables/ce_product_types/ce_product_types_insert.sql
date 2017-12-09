--CE_PRODUCT_TYPES_INSERT.
BEGIN
  pkg_etl_insert_product_types.merge_ce_product_types;
END; 
/