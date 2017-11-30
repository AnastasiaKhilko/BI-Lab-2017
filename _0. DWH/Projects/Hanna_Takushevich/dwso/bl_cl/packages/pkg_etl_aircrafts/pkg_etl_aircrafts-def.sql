CREATE OR REPLACE PACKAGE pkg_etl_aircrafts AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_etl_aircrafts
  Contents...........:   Load data of aircraft entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
  /**
  * Load data to wrk table
  */
  PROCEDURE load_to_wrk;
  /**
  * Load data to cls table
  */
  PROCEDURE load_to_cls;
  /**
  * Load data to 3nf table
  */
  PROCEDURE load_to_3nf;
  
END pkg_etl_aircrafts;