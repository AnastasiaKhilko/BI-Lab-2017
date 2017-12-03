CREATE OR REPLACE PACKAGE pkg_etl_dim_passengers AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_passengers
  Contents...........:   Load data of passenger entity
  Author.............:   Hanna Takushevich
  Date...............:   30-11-2017
  \*=============================================== */
  /**

  /**
  * Load data to dim table
  */
  PROCEDURE load_to_dim;
  
END pkg_etl_dim_passengers;