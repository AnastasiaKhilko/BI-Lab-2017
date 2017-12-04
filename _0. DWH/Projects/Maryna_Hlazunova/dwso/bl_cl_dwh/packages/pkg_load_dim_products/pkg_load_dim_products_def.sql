CREATE OR REPLACE PACKAGE pkg_load_dim_products AS
  /**===============================================*\
  Name...............:   pkg_load_dwh_paydeliveries
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   01-Dec-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_cls2_products;

    PROCEDURE load_dim_products_scd;

END pkg_load_dim_products;
/