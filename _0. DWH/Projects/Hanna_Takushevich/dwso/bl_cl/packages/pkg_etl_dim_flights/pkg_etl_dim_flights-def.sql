CREATE OR REPLACE PACKAGE pkg_etl_dim_flights AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_flights
  Contents...........:   Load data of flight entity
  Author.............:   Hanna Takushevich
  Date...............:   30-11-2017
  \*=============================================== */
  /**

  /**
  * Load data to dim table
  */
PROCEDURE load_to_dim;
  
END pkg_etl_dim_flights;