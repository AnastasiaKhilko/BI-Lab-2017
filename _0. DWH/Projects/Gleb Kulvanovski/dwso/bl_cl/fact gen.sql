SET SERVEROUTPUT ON;


exec procdimdate('DimDate', to_date('15.05.2014', 'DD.MM.YYYY'), sysdate, TRUE);

DROP SEQUENCE salesid;
DROP SEQUENCE paymentsid;

CREATE SEQUENCE salesid START WITH 1;
CREATE SEQUENCE paymentsid START WITH 1;


create table tmp_date AS SELECT rownum as cnt, dd.* FROM(SELECT * FROM DimDate ORDER BY 1) dd;
select * from tmp_date;


create table emp_rand as select id, rank() over (partition by store_id order by id) as rn, store_id+1 store_id, (select distinct count(1) from wrk_employees wrk1 where wrk1.store_id = wrk.store_id AND jobs = 'Seller' group by store_id)
as mx from wrk_employees wrk where jobs = 'Seller';
select * from emp_rand;



declare
rand NUMBER(5,3);
randdate int;
cnt int :=0;
--mindate int;
--maxdate int;
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
coef NUMBER(3,2);
daten TIMESTAMP;
cnt_t INT;
rand_sel int;
id_sel int;
store_rand int;
emp_count int;
id_emp int;
begin

  SELECT count(*) INTO cntdate FROM tmp_date;
  
  FOR cnt1 IN 1..cntdate LOOP  
  rand := dbms_random.value(0,100);
        IF rand <= 7 THEN
            coef := 3;
        ELSIF rand > 7 AND rand < 18 THEN
            coef := 2;
        ELSIF rand > 18 AND rand < 30 THEN
            coef := 1.5;
        ELSIF rand > 30 AND rand < 40 THEN
            coef := .7;
        ELSIF rand > 40 AND rand < 45  THEN
            coef := .5;
        ELSE
            coef := 1;
    END IF;
    
  SELECT to_number(to_char(date_id, 'D')) INTO numberofweek FROM tmp_date WHERE cnt = cnt1;
  
  IF numberofweek < 5 THEN 
      cntsales := trunc(dbms_random.value(30,200));
  ELSIF numberofweek = 5 THEN
      cntsales := trunc(dbms_random.value(70,550));
  ELSE
      cntsales := trunc(dbms_random.value(150,900));
  END IF;
   -- DBMS_OUTPUT.PUT_LINE (to_char(cnt1) || ' ' || to_char(numberofweek) || ' ' ||to_char(cntsales));
    CASE 
        WHEN cnt1 < cntdate/10 THEN
            cntsales := cntsales * .1;
        WHEN cnt1 < cntdate/7 THEN
            cntsales := cntsales * .3;
        WHEN cnt1 < cntdate/5 THEN
            cntsales := cntsales * .7;
        WHEN cnt1 < cntdate/2 THEN
            cntsales := cntsales * 1;
        ELSE cntsales := cntsales * 1.2;
    END CASE;
    
    cntsales := cntsales * coef*1.37;
    
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
      --DBMS_OUTPUT.PUT_LINE(timeint);
      --DBMS_OUTPUT.PUT_LINE(randhh);
      EXECUTE IMMEDIATE 'SELECT to_timestamp(''01.01.0001 08:00:00'' , ''DD.MM.YYYY HH24:MI:SS'') + interval ''' || randss || ''' second 
        + interval ''' || randmi || ''' minute  + interval ''' || randhh || ''' hour from dual' INTO timesal;
/*     CASE 
       WHEN cnt1 < cntdate/10 THEN
            rand_sel := trunc(dbms_random.value(1,30));
        WHEN cnt1 < cntdate/9 THEN
            rand_sel := trunc(dbms_random.value(1,63));
        WHEN cnt1 < cntdate/8 THEN
            rand_sel := trunc(dbms_random.value(1,95));
        WHEN cnt1 < cntdate/7 THEN
            rand_sel := trunc(dbms_random.value(1,127));
        WHEN cnt1 < cntdate/6 THEN
            rand_sel := trunc(dbms_random.value(1,139));
        WHEN cnt1 < cntdate/5 THEN
            rand_sel := trunc(dbms_random.value(1,170));
        WHEN cnt1 < cntdate/4 THEN
            rand_sel := trunc(dbms_random.value(1,214));
        WHEN cnt1 < cntdate/3 THEN
            rand_sel := trunc(dbms_random.value(1,246));
        WHEN cnt1 < cntdate/2 THEN
            rand_sel := trunc(dbms_random.value(1,278));
        ELSE
            rand_sel := trunc(dbms_random.value(1,310));
     END CASE;
*/

    
    CASE 
        WHEN cnt1 < cntdate/10 THEN
            store_rand := round(dbms_random.value(1,2));
        WHEN cnt1 < cntdate/9 THEN
            store_rand := round(dbms_random.value(1,4));
        WHEN cnt1 < cntdate/8 THEN
           store_rand := round(dbms_random.value(1,6));
        WHEN cnt1 < cntdate/7 THEN
           store_rand := round(dbms_random.value(1,8));
        WHEN cnt1 < cntdate/6 THEN
            store_rand := round(dbms_random.value(1,10));
        WHEN cnt1 < cntdate/5 THEN
            store_rand := round(dbms_random.value(1,12));
        WHEN cnt1 < cntdate/4 THEN
            store_rand := round(dbms_random.value(1,14));
        WHEN cnt1 < cntdate/3 THEN
            store_rand := round(dbms_random.value(1,16));
        WHEN cnt1 < cntdate/2 THEN
            store_rand := round(dbms_random.value(1,18));
        ELSE
            store_rand := round(dbms_random.value(1,20));
    END CASE;
                 
        SELECT DISTINCT mx INTO emp_count FROM emp_rand WHERE store_id = store_rand;
        rand_sel := round(dbms_random.value(1, emp_count));
        SELECT id INTO id_emp FROM emp_rand WHERE rn = rand_sel AND store_id = store_rand;  
    --dbms_output.put_line(id_emp);    

    
      INSERT INTO cl_sales
          SELECT
              salesid.nextval,
              CASE trunc(dbms_random.value(1,70))
                 WHEN 3 THEN
                    trunc(dbms_random.value(1,100))
                 ELSE -99
                END,               
              id_emp,   
              store_rand,
              (select date_id from tmp_date where cnt = cnt1),
              timesal        
          FROM dual;     
      LOOP
          cnt_t :=  trunc(dbms_random.value(1,100));  
          INSERT INTO cl_payments
          SELECT
                paymentsid.nextval,
                salesid.currval,
                trunc(dbms_random.value(1,158)), 
                CASE
                    WHEN cnt_t < 90 THEN 1
                    WHEN cnt_t < 95 THEN 2
                    WHEN cnt_t < 98 THEN 3
                    ELSE trunc(dbms_random.value(4,10))
                END
          FROM dual;  
        EXIT WHEN cnt_t > 70;
        END LOOP;
                    
            
      
    END LOOP; 
  --  dbms_output.put_line(numberofweek);
  END LOOP;
END;
/
