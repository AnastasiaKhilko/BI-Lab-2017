--DIM_PAYMENT_METHODS_INSERT.
BEGIN
   pkg_etl_merge_payment_methods.merge_dim_payment_methods;
END;
/
