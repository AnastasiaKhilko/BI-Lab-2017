CREATE OR REPLACE PACKAGE pkg_load_3nf_districts AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_districts
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   24-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_cls_districts;

    PROCEDURE load_ce_districts;

END pkg_load_3nf_districts;
/