CREATE OR REPLACE PACKAGE pkg_load_dim_customers AS
  /**===============================================*\
  Name...............:   pkg_load_dim_customers
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   02-Dec-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_cls2_customers;

    PROCEDURE load_dim_customers_scd;

END pkg_load_dim_customers;
/