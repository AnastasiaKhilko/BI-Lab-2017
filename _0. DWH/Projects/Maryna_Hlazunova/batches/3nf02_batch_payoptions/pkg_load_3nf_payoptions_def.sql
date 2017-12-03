CREATE OR REPLACE PACKAGE pkg_load_3nf_payoptions AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_deliveries
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_payoptions;

    PROCEDURE load_cls_payoptions;

    PROCEDURE load_ce_payoptions;

END pkg_load_3nf_payoptions;
/