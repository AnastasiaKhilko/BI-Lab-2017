CREATE OR REPLACE PACKAGE pkg_load_3nf_customers AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_customers
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_customers;

    PROCEDURE load_wrk_customers2;

    PROCEDURE load_cls_customers;

    PROCEDURE load_ce_customers;

END pkg_load_3nf_customers;
/