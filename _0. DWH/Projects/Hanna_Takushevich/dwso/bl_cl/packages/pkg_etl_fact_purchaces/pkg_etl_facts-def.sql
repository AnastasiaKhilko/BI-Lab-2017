CREATE OR REPLACE PACKAGE pkg_etl_facts AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_etl_regions
  Contents...........:   Load data of region entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */

  /**
  * Load data to fact table
  */
  PROCEDURE load_to_fact;
  
END pkg_etl_facts;