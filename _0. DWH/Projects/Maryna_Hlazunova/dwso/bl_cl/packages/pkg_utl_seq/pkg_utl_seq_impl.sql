/**===============================================*\
Name...............:   pkg_utl_seq
Contents...........:   Package body description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
CREATE OR REPLACE PACKAGE BODY pkg_utl_seq
AS
  FUNCTION seq_getvalue(
      seqname VARCHAR2 )
    RETURN NUMBER
  IS
    seq NUMBER := 0;
  BEGIN
    EXECUTE IMMEDIATE 'select ' || seqname || '.nextval from dual' INTO seq;
    RETURN seq;
  END seq_getvalue;
END pkg_utl_seq;