<<<<<<< HEAD
/*drop table dept;
drop table empl;
drop index idxcl_empl_dept;
drop cluster empl_dept_cluster;*/


--Step 1: create cluster (common shared column) 
 CREATE cluster empl_dept_cluster( deptno NUMBER( 2 ) )
    SIZE 1024 
STORAGE( INITIAL 100K NEXT 50K );

--Step 2: create index on the cluster
   CREATE INDEX idxcl_empl_dept on cluster empl_dept_cluster;

--Step 3: create two tables wuth included cluster
 CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY
  , dname  VARCHAR2( 14 )   , loc    VARCHAR2( 13 )
  )
  cluster empl_dept_cluster ( deptno ) ;

 CREATE TABLE empl
  (
    emplno NUMBER PRIMARY KEY
  , ename VARCHAR2( 10 )   , job   VARCHAR2( 9 )
  , mgr   NUMBER   , hiredate DATE
  , sal    NUMBER   , comm   NUMBER
  , deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster empl_dept_cluster ( deptno ) ;

--Step 4: insert data in both of tables
INSERT INTO dept( deptno , dname , loc)
SELECT deptno , dname , loc    FROM scott.dept;
commit;

 INSERT INTO empl ( emplno, ename, job, mgr, hiredate, sal, comm, deptno )
 SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno
 FROM scott.emp;
commit;

--Step 5:

SELECT *
   FROM
  (
     SELECT dept_blk, empl_blk, CASE WHEN dept_blk <> empl_blk THEN '*' END flag, deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( empl.rowid ) empl_blk, dept.deptno
           FROM empl , dept
          WHERE empl.deptno = dept.deptno
      )
  )
ORDER BY deptno;
=======
/*drop table dept;
drop table empl;
drop index idxcl_empl_dept;
drop cluster empl_dept_cluster;*/


--Step 1: create cluster (common shared column) 
 CREATE cluster empl_dept_cluster( deptno NUMBER( 2 ) )
    SIZE 1024 
STORAGE( INITIAL 100K NEXT 50K );

--Step 2: create index on the cluster
   CREATE INDEX idxcl_empl_dept on cluster empl_dept_cluster;

--Step 3: create two tables wuth included cluster
 CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY
  , dname  VARCHAR2( 14 )   , loc    VARCHAR2( 13 )
  )
  cluster empl_dept_cluster ( deptno ) ;

 CREATE TABLE empl
  (
    emplno NUMBER PRIMARY KEY
  , ename VARCHAR2( 10 )   , job   VARCHAR2( 9 )
  , mgr   NUMBER   , hiredate DATE
  , sal    NUMBER   , comm   NUMBER
  , deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster empl_dept_cluster ( deptno ) ;

--Step 4: insert data in both of tables
INSERT INTO dept( deptno , dname , loc)
SELECT deptno , dname , loc    FROM scott.dept;
commit;

 INSERT INTO empl ( emplno, ename, job, mgr, hiredate, sal, comm, deptno )
 SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno
 FROM scott.emp;
commit;

--Step 5:

SELECT *
   FROM
  (
     SELECT dept_blk, empl_blk, CASE WHEN dept_blk <> empl_blk THEN '*' END flag, deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( empl.rowid ) empl_blk, dept.deptno
           FROM empl , dept
          WHERE empl.deptno = dept.deptno
      )
  )
ORDER BY deptno;
>>>>>>> e9dba30c18f4d0779e4da81e62ed8e6eccde3b78
