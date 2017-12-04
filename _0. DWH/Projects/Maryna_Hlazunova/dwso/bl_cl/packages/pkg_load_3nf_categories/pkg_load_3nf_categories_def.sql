CREATE OR REPLACE PACKAGE pkg_load_3nf_categories AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_categories
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   27-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_refer_products;

    PROCEDURE load_cls_categories;

    PROCEDURE load_ce_categories;

END pkg_load_3nf_categories;
/