CREATE OR REPLACE PACKAGE pkg_load_3nf_pickuppoints AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_pickuppoints
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_pickuppoints;

    PROCEDURE load_cls_pickuppoints;

    PROCEDURE load_ce_pickuppoints;

END pkg_load_3nf_pickuppoints;
/