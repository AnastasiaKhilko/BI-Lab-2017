CREATE OR REPLACE FUNCTION tst_function (  p_number IN NUMBER )
  RETURN BOOLEAN
IS
BEGIN
  DBMS_LOCK.SLEEP ( p_number) ;

  RETURN true;

END;
/

-------------------------------------------------------------------------

SELECT DBMS_UTILITY.GET_TIME ( ) FROM dual;

SET serveroutput ON;

DECLARE
  l_bool  BOOLEAN := false;
  l_cnt   INTEGER := 1e2;
  l_start INTEGER;
BEGIN
  l_start := dbms_utility.get_time ( ) ;

  FOR i IN 1..l_cnt
  LOOP

    IF l_bool AND tst_function ( 1 ) THEN
      NULL;

    END IF;

  END LOOP;
  dbms_output.put_line ( 'First: '||TO_CHAR ( ( dbms_utility.get_time
  ( ) - l_start ) ) ) ;
  l_start := dbms_utility.get_time ( ) ;

  FOR i IN 1..l_cnt
  LOOP

    IF tst_function ( 1 ) AND l_bool THEN
      NULL;

    END IF;

  END LOOP;
  dbms_output.put_line ( 'Second: '||TO_CHAR ( (
  dbms_utility.get_time ( ) - l_start ) ) ) ;

END;


-------------------------------------------------------------------------

DECLARE
  l_cnt      INTEGER := 1e6;
  l_start    INTEGER;
  region_id1 VARCHAR2 ( 2 ) := 'NE';
  region_id2 VARCHAR2 ( 2 ) := 'qW';
  mgr_name   VARCHAR2 ( 5 ) ;
BEGIN
  l_start := dbms_utility.get_time ( ) ;

  FOR i IN 1..l_cnt
  LOOP

    CASE region_id1
    WHEN 'NE' THEN
      mgr_name := 'MINER';

    WHEN 'SE' THEN
      mgr_name := 'KOOI';

    WHEN 'SD' THEN
      mgr_name := 'KOOI';

    WHEN 'SQ' THEN
      mgr_name := 'KOOI';

    WHEN 'qW' THEN
      mgr_name := 'KOOI';

    ELSE
      mgr_name := 'LANE';

    END CASE;

  END LOOP;
  dbms_output.put_line ( 'First: '||TO_CHAR ( ( dbms_utility.get_time
  ( ) - l_start ) ) ) ;
  l_start := dbms_utility.get_time ( ) ;

  FOR i IN 1..l_cnt
  LOOP

    CASE region_id2
    WHEN 'NE' THEN
      mgr_name := 'MINER';

    WHEN 'SE' THEN
      mgr_name := 'KOOI';

    WHEN 'SD' THEN
      mgr_name := 'KOOI';

    WHEN 'SQ' THEN
      mgr_name := 'KOOI';

    WHEN 'qW' THEN
      mgr_name := 'KOOI';

    ELSE
      mgr_name := 'LANE';

    END CASE;

  END LOOP;
  dbms_output.put_line ( 'Second: '||TO_CHAR ( (
  dbms_utility.get_time ( ) - l_start ) ) ) ;

END;

-------------------------------------------------------------------------

DECLARE
  l_start    INTEGER;
  l_obj org%ROWTYPE;

  CURSOR cur_obj
  IS
     SELECT * FROM org;
BEGIN
  l_start := dbms_utility.get_time ( ) ;
  OPEN cur_obj;
  LOOP

    FETCH cur_obj INTO l_obj;
    EXIT
  WHEN cur_obj%NOTFOUND;
    NULL;

  END LOOP;
  CLOSE cur_obj;
  dbms_output.put_line ( 'Explicit: '||TO_CHAR ( (
  dbms_utility.get_time ( ) - l_start ) ) ) ;
  l_start := dbms_utility.get_time ( ) ;
  l_start := dbms_utility.get_time ( ) ;

  FOR i IN
  ( SELECT * FROM org
  )
  LOOP
    NULL;

  END LOOP;
  dbms_output.put_line ( 'Implicit: '||TO_CHAR ( (
  dbms_utility.get_time ( ) - l_start ) ) ) ;

END;



