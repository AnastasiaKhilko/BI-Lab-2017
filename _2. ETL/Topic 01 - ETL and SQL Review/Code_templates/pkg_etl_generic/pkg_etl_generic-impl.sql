CREATE OR REPLACE PACKAGE body pkg_etl_generic
AS
  /**===============================================*\
  Name...............:   pkg_etl_generic
  Contents...........:   Package description
  Author.............:   Author name
  Date...............:   Date of last update
  \*=============================================== */
  /**
  * Constants for logging if needed (Description of each)
  */
  c_constant_name ...

/****************************************************/  
  PROCEDURE my_procedure
  IS
    /*Procedure name for logging*/
    c_procedure_name CONSTANT VARCHAR2(30):= UPPER('my_procedure');
    /*Local variables*/
    l_variable_name ...
  BEGIN
    NULL;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END my_procedure;

END pkg_etl_generic;
/ 