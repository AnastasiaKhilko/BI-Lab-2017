CREATE OR REPLACE PACKAGE pkg_load_3nf_facts AS
  /**===============================================*\
  Name...............:   pkg_gen_3nf_facts
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   30-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_fct_orders;

    PROCEDURE load_cls_fct_orders;

    PROCEDURE load_ce_fct_orders;

    PROCEDURE load_cls_fct_items;

    PROCEDURE load_ce_fct_items;

END pkg_load_3nf_facts;
/