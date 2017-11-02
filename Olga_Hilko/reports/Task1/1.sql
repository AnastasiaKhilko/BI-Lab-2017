--Step 1: cterate table with large object types (it empty)
create table t1 ( x int primary key, y clob, z blob );

--Step 2: after select nothing happend, only T-segment was visible 
-- because the table is empty and segment was not created
select segment_name, segment_type from user_segments;

--Step 3.1: empty table with immidiate segment creation was added
Create table t2 ( 
x int primary key,
 y clob,
 z blob 
)
SEGMENT CREATION IMMEDIATE

--Step 3.1: segments for t and t2 are visible, t1 is empty - no segment was created
select segment_name, segment_type from user_segments;

select segment_name, segment_type from user_segments; --where table_name = 'T2';

--Step 4:
#  select segment_name, segment_type 2 from user_segments;

--Step 5: 
 SELECT DBMS_METADATA.GET_DDL('TABLE','T1') FROM dual;

SELECT * FROM user_tables;