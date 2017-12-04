CREATE OR REPLACE PACKAGE pkg_load_3nf_products AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_products
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   29-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_products;

    PROCEDURE load_cls_colors;

    PROCEDURE load_ce_colors;

    PROCEDURE load_cls_products;

    PROCEDURE load_ce_products;

END pkg_load_3nf_products;
/