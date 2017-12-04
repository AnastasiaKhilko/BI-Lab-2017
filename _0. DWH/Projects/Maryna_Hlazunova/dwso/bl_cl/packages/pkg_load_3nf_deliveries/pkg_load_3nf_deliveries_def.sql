CREATE OR REPLACE PACKAGE pkg_load_3nf_deliveries AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_deliveries
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_deliveries;

    PROCEDURE load_cls_deliveries;

    PROCEDURE load_ce_deliveries;

END pkg_load_3nf_deliveries;
/