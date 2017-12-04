CREATE OR REPLACE PACKAGE pkg_load_fct_salesitems AS
  /**===============================================*\
  Name...............:   pkg_load_fct_salesitems
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   02-Dec-2017
  \*=============================================== */
  /****************************************************/
    PROCEDURE load_cls2_fct_salesitems;

    PROCEDURE load_fct_salesitems;

END pkg_load_fct_salesitems;
/