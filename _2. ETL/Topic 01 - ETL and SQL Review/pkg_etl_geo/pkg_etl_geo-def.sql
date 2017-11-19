--DROP PACKAGE pkg_etl_generic;
 
CREATE OR REPLACE PACKAGE pkg_etl_geo
AS
  /**===============================================*\
  Name...............:   pkg_etl_geo
  Contents...........:   Package loads GEO tables
  Author.............:   Author name
  Date...............:   Date of last update
  \*=============================================== */
  
  /**
  * Package constants if needed (Description of each)
  */
  --c_constant_name ...
  
  /**
  * Loads cleansisng table for geo structure
  */
  
  
  /**
  * Loads T_WORLDS
  */
  PROCEDURE load_worlds;
END pkg_etl_geo;
/