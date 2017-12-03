CREATE OR REPLACE PACKAGE pkg_load_dim_pickuppoints AS
  /**===============================================*\
  Name...............:   pkg_load_dwh_paydeliveries
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   01-Dec-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_cls2_pickuppoints;

    PROCEDURE load_dim_pickuppoints;

END pkg_load_dim_pickuppoints;
/