CREATE OR REPLACE PACKAGE pkg_load_dim_paydeliveries AS
  /**===============================================*\
  Name...............:   pkg_load_dim_paydeliveries
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   01-Dec-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_cls2_paydeliveries;

    PROCEDURE load_dim_paydeliveries;

END pkg_load_dim_paydeliveries;
/