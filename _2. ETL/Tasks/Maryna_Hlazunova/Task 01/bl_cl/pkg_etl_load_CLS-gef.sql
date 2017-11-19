CREATE OR REPLACE PACKAGE pkg_etl_load_cls AS
  /**===============================================*\
  Name...............:   pkg_etl_load
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   17-Nov-2017
  \*=============================================== */
  /****************************************************/

  /* Loads cleansisng tables for geo structure */
    PROCEDURE load_cls_structure;

    PROCEDURE load_cls_countries;

    PROCEDURE load_cls_countries_reg;

END pkg_etl_load_cls;
/