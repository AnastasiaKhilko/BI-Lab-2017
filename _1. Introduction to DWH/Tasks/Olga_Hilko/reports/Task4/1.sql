--1.1.1.	Step 1
drop table t2;
 CREATE TABLE t2 AS
 SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
CONNECT BY rownum < 100000;
--1.1.2.	Step 2
CREATE INDEX t2_idx1 ON t2 ( id );
--1.1.3.	Step 3
--Number of blocks used by segment:
SELECT blocks FROM user_segments WHERE segment_name = 'T2';
--Number of blocks used by real data: 
SELECT COUNT(DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct
FROM t2 ;
select id, dbms_rowid.rowid_block_number( rowid) blockNo,
vsize(id) a_Size, vsize(t_pad), vsize(id) + vsize(t_pad) all_s from t2;
SELECT COUNT( * ) FROM t2;
DELETE FROM t2;
drop table t2;

--1.1.4.	Step 4
Delete all rows from the table:
  DELETE FROM t2;
--1.1.5.	Step 5
Repeat Step 3 and collect results.
--1.1.6.	Step 6
--Insert 1 row:
  INSERT INTO t2
  ( ID, T_PAD )
  VALUES
  (  1,'1' );

--COMMIT;
--1.1.7.	Step 7
--Repeat Step 3 and collect results.
--1.1.8.	Step 8
--Truncate table:
   TRUNCATE TABLE t2;
--1.1.9.	Step 9
--Repeat Step 3 and collect results.
