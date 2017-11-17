CREATE OR REPLACE PACKAGE body pkg_etl_geo
AS
  /**===============================================*\
  Name...............:   pkg_etl_generic
  Contents...........:   Package description
  Author.............:   Author name
  Date...............:   Date of last update
  \*=============================================== */
  /****************************************************/
PROCEDURE load_cls_geo_structure
IS
BEGIN
  EXECUTE immediate 'truncate table cls_geo_structure';

   INSERT INTO cls_geo_structure
  SELECT DISTINCT * FROM EXT_GEO_STRUCTURE_ISO3166;
  COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END load_cls_geo_structure;
/****************************************************/

PROCEDURE load_worlds
IS
BEGIN

   DELETE
     FROM t_worlds
    WHERE WORLD_CODE NOT IN
    ( SELECT child_code FROM cls_geo_structure WHERE STRUCTURE_LEVEL
      = 'World'
    ) ;

  MERGE INTO t_worlds t USING
  ( SELECT child_code as WORLD_CODE
  , structure_desc as WORLD_DESCRIPTION
     FROM cls_geo_structure
    WHERE STRUCTURE_LEVEL   = 'World'
    MINUS
  SELECT WORLD_CODE, WORLD_DESCRIPTION FROM t_worlds   
  ) cls ON ( cls.WORLD_CODE = t.world_code )
WHEN matched THEN
   UPDATE SET t.WORLD_DESCRIPTION = cls.WORLD_DESCRIPTION WHEN NOT
    matched THEN
   INSERT
    (
      WORLD_ID
    , WORLD_CODE
    , WORLD_DESCRIPTION
    )
    VALUES
    (
      seq_worlds.nextval
    , cls.WORLD_CODE
    , cls.WORLD_DESCRIPTION
    ) ;
  COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END load_worlds;

END pkg_etl_geo;
/ 