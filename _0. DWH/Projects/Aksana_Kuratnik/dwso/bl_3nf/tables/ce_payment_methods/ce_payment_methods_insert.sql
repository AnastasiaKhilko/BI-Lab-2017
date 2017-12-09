--CE_PAYMENT_METHODS_INSERT.
BEGIN
  pkg_etl_insert_payment_methods.merge_ce_payment_methods;
END; 
/ 
