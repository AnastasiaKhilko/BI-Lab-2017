--2.1.1.	Step 1
--Create table t2 as in task 1 steps 1-2
 CREATE TABLE t2 AS
 SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
CONNECT BY rownum < 100000;
CREATE INDEX t2_idx1 ON t2 ( id );
--2.1.2.	Step 2
--Create table t1 as listed below:
  CREATE TABLE t1 AS
 SELECT MOD( rownum, 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
  CONNECT BY rownum < 100000;
--2.1.3.	Step 3
 CREATE INDEX t1_idx1 ON t1
  ( id );
--2.1.4.	Step 4
--Don’t forget to gather statistics for both tables:
EXEC dbms_stats.gather_table_stats( USER,'t1',method_opt=>'FOR ALL COLUMNS SIZE 1',CASCADE=>TRUE );
EXEC dbms_stats.gather_table_stats( USER,'t2',method_opt=>'FOR ALL COLUMNS SIZE 1',CASCADE=>TRUE );
--2.1.5.	Step 5
--View index clustering factor:
  SELECT t.table_name||'.'||i.index_name idx_name,
        i.clustering_factor,
        t.blocks,
        t.num_rows
   FROM user_indexes i, user_tables t
  WHERE i.table_name = t.table_name
    AND t.table_name  IN( 'T1','T2' );

select t2.*, t1.* from t2, t1 where t2.T_PAD = t1.T_PAD;
select * from t2 where id IN (1,2,3,4,5);
select * from t1 where id IN (1,2,3,4,5);
select * from t1 ORDER BY  2, 1;

--2.2.1.	Step 1
CREATE UNIQUE INDEX udx_t1 ON t1( t_pad );
--2.2.2.	Step 2
SELECT tb.*  FROM t1 tb where tb.t_pad = '1';
SELECT tb.*  FROM t1 tb where tb.t_pad =rpad('1',100);
SELECT t1.* , vsize(t_pad) FROM t1; --where t1.t_pad =rpad('1',100);
--select * from udx_t1;

  SELECT t2.*  FROM t2 where t2.id = '1';
    SELECT t2.*  FROM t2 where t2.id = 1;