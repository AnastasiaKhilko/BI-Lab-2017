CREATE TABLE t1 AS
 SELECT MOD( rownum, 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
  CONNECT BY rownum < 100000;
CREATE INDEX t1_idx1 ON t1
  ( id );

CREATE TABLE t2 AS
 SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
CONNECT BY rownum < 100000;
CREATE INDEX t2_idx1 ON t2 ( id );


create table merge_emp as select * from scott.emp;

create index ind_merge_emp on merge_emp(empno)

create table merge_emp_1 as select * from scott.emp;
