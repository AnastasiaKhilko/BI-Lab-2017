SET SERVEROUTPUT ON;

create table tmp_date AS SELECT rownum as cnt, dd.* FROM(SELECT * FROM DimDate ORDER BY 1) dd;

CREATE SEQUENCE factid START WITH 1;

declare
rand int;
randdate int;
cnt int :=0;
mindate int;
maxdate int;
cntdate int;
cntsales int;
cntslday int := 0;
randss int;
randmi int;
randhh int;
numberofweek int;
timeint NUMBER(10,9);
timesal TIMESTAMP;
sql_st VARCHAR2(4000);
begin
  SELECT count(*) INTO cntdate FROM tmp_date;
  FOR cnt IN 1..10 LOOP
  rand := dbms_random.value(0,1);
  CASE
    WHEN rand <= 0.1 THEN
      mindate := 1;
      maxdate := trunc(cntdate/20);
    WHEN rand > 0.1 AND rand <= 0.3 THEN
      mindate := trunc(cntdate/20);
      maxdate := trunc(cntdate/12);
    WHEN rand > 0.3 AND rand <= 0.5 THEN
      mindate := trunc(cntdate/12);
      maxdate := trunc(cntdate/7);
    ELSE
      mindate := trunc(cntdate/7);
      maxdate := trunc(cntdate);
  END CASE;
  randdate := trunc(dbms_random.value(mindate,maxdate));
  SELECT to_number(to_char(date_id, 'D')) INTO numberofweek FROM tmp_date WHERE cnt = randdate;
  IF numberofweek < 5 THEN 
      cntsales := trunc(dbms_random.value(1,50));
  ELSIF numberofweek = 5 THEN
      cntsales := trunc(dbms_random.value(10,150));
  ELSE
      cntsales := trunc(dbms_random.value(50,500));
  END IF;
  FOR cntslday IN 1..cntsales LOOP
      timeint := dbms_random.value(0,1);
      IF timeint <= 0.2 AND numberofweek < 6 THEN
        randss :=  trunc(dbms_random.value(0,60));
        randmi :=  trunc(dbms_random.value(0,60));
        randhh :=  trunc(dbms_random.value(0,3));
      ELSIF timeint > 0.2 AND timeint <= 0.4 AND numberofweek < 6 THEN
        randss :=  trunc(dbms_random.value(0,60));
        randmi :=  trunc(dbms_random.value(0,60));
        randhh :=  trunc(dbms_random.value(3,9));
      ELSIF timeint > 0.4 AND timeint <= 0.8 AND numberofweek < 6 THEN
        randss :=  trunc(dbms_random.value(0,60));
        randmi :=  trunc(dbms_random.value(0,60));
        randhh :=  trunc(dbms_random.value(9,12));
      ELSIF timeint > 0.8 AND timeint <= 1 AND numberofweek < 6 THEN
        randss :=  trunc(dbms_random.value(0,60));
        randmi :=  trunc(dbms_random.value(0,60));
        randhh :=  trunc(dbms_random.value(12,14));
      ELSIF timeint <= 0.2 AND numberofweek >= 6 THEN
        randss :=  trunc(dbms_random.value(0,60));
        randmi :=  trunc(dbms_random.value(0,60));
        randhh :=  trunc(dbms_random.value(0,3));
      ELSIF timeint > 0.2 AND timeint <= 0.6 AND numberofweek >= 6 THEN
        randss :=  trunc(dbms_random.value(0,60));
        randmi :=  trunc(dbms_random.value(0,60));
        randhh :=  trunc(dbms_random.value(3,9));
      ELSIF timeint > 0.6 AND timeint <= 0.9 AND numberofweek >= 6 THEN
        randss :=  trunc(dbms_random.value(0,60));
        randmi :=  trunc(dbms_random.value(0,60));
        randhh :=  trunc(dbms_random.value(9,12));
       ELSIF timeint > 0.9 AND timeint <= 1 AND numberofweek >= 6 THEN
        randss :=  trunc(dbms_random.value(0,60));
        randmi :=  trunc(dbms_random.value(0,60));
        randhh :=  trunc(dbms_random.value(12,14));
      ELSE
      DBMS_OUTPUT.PUT_LINE('Error');
      END IF;
      DBMS_OUTPUT.PUT_LINE(timeint);
      DBMS_OUTPUT.PUT_LINE(randhh);
      EXECUTE IMMEDIATE 'SELECT to_timestamp(''01.01.0001 08:00:00'' , ''DD.MM.YYYY HH24:MI:SS'') + interval ''' || randss || ''' second 
        + interval ''' || randmi || ''' minute  + interval ''' || randhh || ''' hour from dual' INTO timesal;
      INSERT INTO factsales
      SELECT
          factid.nextval,
          cnt+65531,
          trunc(dbms_random.value(1,10000)),
          trunc(dbms_random.value(1,10000)),
          trunc(dbms_random.value(1,10000)),
          (select date_id from tmp_date where cnt = randdate),
          trunc(dbms_random.value(1,10000)),
          trunc(dbms_random.value(10,5600),2),
          timesal          
      FROM dual;
    END LOOP;
    dbms_output.put_line(numberofweek);
  END LOOP;
END;
/