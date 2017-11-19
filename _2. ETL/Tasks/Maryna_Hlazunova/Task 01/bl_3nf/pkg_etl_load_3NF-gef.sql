CREATE OR REPLACE PACKAGE pkg_etl_load_3nf AS
  /**===============================================*\
  Name...............:   pkg_etl_load_3nf
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   17-Nov-2017
  \*=============================================== */
  /****************************************************/

  /* Loads 3NF tables */
    PROCEDURE load_ce_worlds;

    PROCEDURE load_ce_continents;

    PROCEDURE load_ce_regions;

    PROCEDURE load_ce_countries;

END pkg_etl_load_3nf;
/