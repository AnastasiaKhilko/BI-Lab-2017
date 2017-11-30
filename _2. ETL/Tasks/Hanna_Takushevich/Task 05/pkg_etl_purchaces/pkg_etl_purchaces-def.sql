CREATE OR REPLACE PACKAGE pkg_etl_purchaces AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_etl_purchaces
  Contents...........:   Load data of purchaces
  Author.............:   Hanna Takushevich
  Date...............:   29-11-2017
  \*=============================================== */
  
   /**
  * Load data to cls table
  */
  PROCEDURE load_to_cls;
  /**
  * Load data to 3nf table
  */
  PROCEDURE load_to_3nf;
  
END pkg_etl_purchaces;
