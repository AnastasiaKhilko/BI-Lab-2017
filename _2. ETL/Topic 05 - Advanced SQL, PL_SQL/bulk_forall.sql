 CREATE TABLE emp_tst AS
 SELECT   rownum AS emp_id
  , he.*
     FROM hr.employees he
  , ( SELECT level FROM dual CONNECT BY level <= 100
    ) ;

 SELECT * FROM emp_tst;

CREATE OR REPLACE FUNCTION check_raise (
    p_id_in NUMBER )
  RETURN BOOLEAN
IS
BEGIN

  IF mod ( p_id_in, 2 ) = 0 THEN

    RETURN true;

  ELSE

    RETURN false;

  END IF;

END;
/

CREATE OR REPLACE PROCEDURE give_raise (
    p_dpt_in IN NUMBER )
IS
type emp_id_aat
IS
  TABLE OF emp_tst.emp_id%TYPE INDEX BY pls_integer;
  emp_all emp_id_aat;
  emp_raise emp_id_aat;
BEGIN

   SELECT   emp_id bulk collect
       INTO emp_all
       FROM emp_tst
      WHERE department_id = p_dpt_in;

  FOR i IN 1..emp_all.count
  LOOP

    IF check_raise ( emp_all ( i ) ) THEN
      emp_raise ( emp_raise.count + 1 ) := emp_all ( i ) ;

    END IF;

  END LOOP;
  forall i IN 1..emp_raise.count

   UPDATE emp_tst SET salary = salary * 1.05 WHERE emp_id = emp_raise
      ( i ) ;

END;
/

CREATE OR REPLACE PROCEDURE give_raise (
    p_dpt_in IN NUMBER )
IS
type emp_id_aat
IS
  TABLE OF emp_tst.emp_id%TYPE INDEX BY pls_integer;
  emp_all emp_id_aat;
  emp_raise emp_id_aat;
BEGIN

   SELECT   emp_id bulk collect
       INTO emp_all
       FROM emp_tst
      WHERE department_id = p_dpt_in;

  FOR i IN 1..emp_all.count
  LOOP

    IF check_raise ( emp_all ( i ) ) THEN
      emp_raise ( emp_raise.count + 1 ) := emp_all ( i ) ;

    END IF;

  END LOOP;
  forall i IN 1..emp_raise.count

   UPDATE emp_tst SET salary = salary * 1.05 WHERE emp_id = emp_raise
      ( i ) ;

END;
/
TYPE table_nt
IS
  TABLE OF        NUMBER;
TYPE table_vat IS VARRAY ( 10 ) OF NUMBER;
SET serveroutput ON

DECLARE
TYPE table_vat IS VARRAY ( 5 ) OF VARCHAR2 ( 100 ) ;
l_vat table_vat;
i INTEGER;
BEGIN
  l_vat := table_vat ( 'a', 'd', 'weqw', 'sd', 'df' ) ;
  l_vat.trim ( 3 ) ;
  i := l_vat.first;

  WHILE ( i IS NOT NULL )
  LOOP
    dbms_output.put_line ( i||': '||l_vat ( i ) ) ;
    i := l_vat.next ( i ) ;

  END LOOP;
  dbms_output.put_line ( 'limit: '||l_vat.limit ) ;

END;
/

DECLARE
TYPE table_nt
IS
  TABLE OF VARCHAR2 ( 100 ) ;
  l_nt table_nt := table_nt ( ) ;
  i INTEGER;
BEGIN
  l_nt.extend ( 5 ) ;
  l_nt ( 1 ) := 'qwe';
  l_nt ( 4 ) := 'qwwe';
  l_nt.delete ( 1 ) ;
  l_nt ( 3 ) := 'qwwe';
  l_nt.extend;
  l_nt.trim;
  i := l_nt.first;

  WHILE ( i IS NOT NULL )
  LOOP
    dbms_output.put_line ( i||': '||l_nt ( i ) ) ;
    i := l_nt.next ( i ) ;

  END LOOP;
  dbms_output.put_line ( 'count: '||l_nt.count ) ;
  dbms_output.put_line ( 'limit: '||l_nt.limit ) ;

END;
/

DECLARE
TYPE table_aat
IS
  TABLE OF NUMBER INDEX BY VARCHAR2 ( 100 ) ;
  l_aat table_aat;
  i VARCHAR2 ( 100 ) ;
BEGIN
  l_aat ( 'Olya' )    := 11;
  l_aat ( 'Natasha' ) := 21;
  l_aat ( 'Masha' )   := 31;
  i                   := l_aat.first;

  WHILE ( i IS NOT NULL )
  LOOP
    dbms_output.put_line ( i||': '||l_aat ( i ) ) ;
    i := l_aat.next ( i ) ;

  END LOOP;
  dbms_output.put_line ( 'count: '||l_aat.count ) ;

END;
/
