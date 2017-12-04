CREATE OR REPLACE PACKAGE pkg_load_3nf_brands AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_brands
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_brands;

    PROCEDURE load_cls_brands;

    PROCEDURE load_ce_brands;

END pkg_load_3nf_brands;
/