CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cls
AS
  /**===============================================*\
  Name...............:   pkg_etl_load_cls
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   17-Nov-2017
  \*=============================================== */
  /****************************************************/
  PROCEDURE load_cls_structure
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cls_geo_structure';
    INSERT INTO cls_structure
    SELECT * FROM src_structure;
    COMMIT;
    dbms_output.put_line('The data in the table CLS_STRUCTURE is loaded successfully!');
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cls_structure;
/****************************************************/
/****************************************************/
  PROCEDURE load_cls_countries
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cls_geo_countries';
    INSERT INTO cls_countries
    SELECT * FROM src_countries;
    COMMIT;
    dbms_output.put_line('The data in the table CLS_COUNTRIES is loaded successfully!');
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cls_countries;
/****************************************************/
/****************************************************/
  PROCEDURE load_cls_countries_reg
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cls_cnt_structure';
    INSERT INTO cls_countries_reg
    SELECT * FROM src_countries_reg;
    COMMIT;
    dbms_output.put_line('The data in the table CLS_COUNTRIES_REG is loaded successfully!');
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cls_countries_reg;
/****************************************************/
END pkg_etl_load_cls;
/