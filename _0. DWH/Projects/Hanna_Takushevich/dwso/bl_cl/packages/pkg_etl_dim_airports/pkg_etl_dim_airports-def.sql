CREATE OR REPLACE PACKAGE pkg_etl_dim_airports AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_airports
  Contents...........:   Load data of airport entity
  Author.............:   Hanna Takushevich
  Date...............:   30-11-2017
  \*=============================================== */
  /**

  /**
  * Load data to dim table
  */
  PROCEDURE load_to_dim;
  
END pkg_etl_dim_airports;