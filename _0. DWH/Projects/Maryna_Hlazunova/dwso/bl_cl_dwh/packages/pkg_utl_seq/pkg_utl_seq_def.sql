CREATE OR REPLACE PACKAGE pkg_utl_seq AS
  /**===============================================*\
  Name...............:   pkg_utl_seq
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
  
    FUNCTION seq_getvalue (seqname VARCHAR2 ) RETURN NUMBER;

END pkg_utl_seq;
/