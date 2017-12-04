CREATE OR REPLACE PACKAGE pkg_load_3nf_regions AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_regions
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   24-Nov-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_wrk_locations;

    PROCEDURE load_cls_regions;

    PROCEDURE load_ce_regions;

END pkg_load_3nf_regions;
/