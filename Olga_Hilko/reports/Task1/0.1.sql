<<<<<<< HEAD
--Step 1: table t was created
create table t
  ( a int,
    b varchar2(4000) default rpad('*',4000,'*'),
    c varchar2(3000) default rpad('*',3000,'*')
   )

--Step 2: 3 records to table t were added
-- results were commited
insert into t (a) values ( 1);
insert into t (a) values ( 2);
insert into t (a) values ( 3);
commit;

-- delete row #2 (with a = 2)
-- add new row with #4
delete from t where a = 2 ;
commit;
insert into t (a) values ( 4);
commit;

--Step 3:
select a, dbms_rowid.rowid_block_number( rowid) blockNo from t;


show parameter block_size;
select distinct bytes/blocks from user_segments;
SELECT name,value
  FROM v$parameter
 WHERE name = 'db_block_size';


insert into t (a,b,c) values ( 5, '***', '+++');
insert into t (a,b,c) values ( 6, '***', '+++');
insert into t (a,b,c) values ( 7, '***', '+++');
commit;

--Step 3:
select a, dbms_rowid.rowid_block_number( rowid) blockNo,
vsize(a) a_Size, vsize(b) b_Size, vsize(c) ?_Size, vsize(a)+vsize(b)+vsize(c) "a+b+c" from t;


SELECT pct_free, PCT_USED FROM user_tables WHERE table_name = 'T';


=======
--Step 1: table t was created
create table t
  ( a int,
    b varchar2(4000) default rpad('*',4000,'*'),
    c varchar2(3000) default rpad('*',3000,'*')
   )

--Step 2: 3 records to table t were added
-- results were commited
insert into t (a) values ( 1);
insert into t (a) values ( 2);
insert into t (a) values ( 3);
commit;

-- delete row #2 (with a = 2)
-- add new row with #4
delete from t where a = 2 ;
commit;
insert into t (a) values ( 4);
commit;

--Step 3:
select a, dbms_rowid.rowid_block_number( rowid) blockNo from t;


show parameter block_size;
select distinct bytes/blocks from user_segments;
SELECT name,value
  FROM v$parameter
 WHERE name = 'db_block_size';


insert into t (a,b,c) values ( 5, '***', '+++');
insert into t (a,b,c) values ( 6, '***', '+++');
insert into t (a,b,c) values ( 7, '***', '+++');
commit;

--Step 3:
select a, dbms_rowid.rowid_block_number( rowid) blockNo,
vsize(a) a_Size, vsize(b) b_Size, vsize(c) ?_Size, vsize(a)+vsize(b)+vsize(c) "a+b+c" from t;


SELECT pct_free, PCT_USED FROM user_tables WHERE table_name = 'T';


>>>>>>> e9dba30c18f4d0779e4da81e62ed8e6eccde3b78
