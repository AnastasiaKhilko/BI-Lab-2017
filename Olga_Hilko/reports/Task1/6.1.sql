drop table t6;
--Step 1 : create table
create table t6
  ( a int,
    b varchar2(4000) default rpad('*',3000,'*'),
    c varchar2(4000) default rpad('*',3000,'*'),
    d varchar2(4000) default rpad('*',1000,'*')
   );

--Step 2: 3 records to table t were added
-- results were commited
insert into t6 (a) values ( 1);
insert into t6 (a) values ( 2);
insert into t6 (a) values ( 3);

commit;
select b,c from t6;
--Step 3:
select a, dbms_rowid.rowid_block_number( rowid) blockNo,
vsize(a) a_Size, vsize(b) b_Size, vsize(c) ?_Size, 
vsize(d) d_Size,
vsize(a)+vsize(b)+vsize(c)+vsize(d) "a+b+c+d size" from t6;
--Step 4:
update t6
set d=c
where a=2;
commit;

insert into t6 (a) values ( 4);
commit;

select a, 
--rowid "rowID", 
dbms_rowid.rowid_block_number( rowid) blockNo,
vsize(a) a_Size, vsize(b) b_Size, vsize(c) ?_Size, 
vsize(d) d_Size,
vsize(a)+vsize(b)+vsize(c)+vsize(d) "a+b+c+d size" from t6
where dbms_rowid.rowid_block_number( rowid)=13445
;
 
 
 select rowid "rowID", a from t6
where dbms_rowid.rowid_block_number( rowid)=13446
;
 
 

select DBMS_ROWID.ROWID_OBJECT(rowid) "OBJECT",
DBMS_ROWID.ROWID_RELATIVE_FNO(rowid) "FILE",
DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) "BLOCK",
DBMS_ROWID.ROWID_ROW_NUMBER(rowid) "ROW"
from T6;



drop table t7;
--Step 1 : create table
create table t7
  ( a int,
    b varchar2(4000) default rpad('*',4000,'*'),
    c varchar2(4000) default rpad('*',3000,'*'),
    d varchar2(4000) default rpad('*',1000,'*')
   );

--Step 2: 3 records to table t were added
-- results were commited
insert into t7 (a) values ( 1);
insert into t7 (a) values ( 2);
insert into t7 (a) values ( 3);

select a, 
--rowid "rowID", 
dbms_rowid.rowid_block_number( rowid) blockNo,
vsize(a) a_Size, vsize(b) b_Size, vsize(c) ?_Size, 
vsize(d) d_Size,
vsize(a)+vsize(b)+vsize(c)+vsize(d) "a+b+c+d size" from t7
;
 select * from dba_extents where Owner = user order by 2 desc;