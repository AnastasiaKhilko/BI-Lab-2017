DROP TABLE source_table;

CREATE TABLE source_table AS select 1 id, 'a' name from dual;

DROP TABLE target_table;

CREATE TABLE target_table AS select 1id, 1 src_id, 'a' name, trunc(sysdate) start_dt, trunc(sysdate) end_dt from dual
where 1=0;

DROP TABLE cls_table;

CREATE TABLE cls_table AS select 1 id, 'a' name, trunc(sysdate) start_dt, trunc(sysdate) end_dt from dual
where 1=0;

SELECT * FROM source_table;

SELECT * FROM target_table;

truncate table 
cls_table;

-------------- 1 --------------------

INSERT INTO cls_table 
SELECT src.id, src.name, TO_DATE('01/01/1900','DD/MM/YYYY') start_dt, TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
FROM source_table src;

commit;

create sequence test_table;

MERGE INTO target_table tgt
USING (SELECT * FROM cls_table) src
ON (src.id = tgt.src_id 
AND src.start_dt = tgt.start_dt)
WHEN MATCHED THEN 
UPDATE SET tgt.name = src.name,
tgt.end_dt = src.end_dt
WHEN NOT MATCHED THEN 
INSERT (id, src_id, name, start_dt, end_dt)
VALUES (test_table.nextval, src.id, src.name, src.start_dt, src.end_dt);

commit;

select * from target_table;

--------------- 2 -----------------
update source_table set name = 'b';

commit;

select * from source_table;

truncate table cls_table;

INSERT INTO cls_table 
SELECT src.id, src.name, NVL2(tgt.src_id, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt, TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
FROM source_table src left join target_table tgt
ON (tgt.start_dt<= TRUNC(sysdate)
and tgt.end_dt > TRUNC(sysdate)
and tgt.src_id = src.id)
WHERE DECODE(src.name, tgt.name, 0,1)>0
UNION ALL
SELECT tgt.src_id, tgt.name, tgt.start_dt, TRUNC(sysdate) end_dt
FROM source_table src  join target_table tgt
ON (tgt.start_dt<= TRUNC(sysdate)
and tgt.end_dt > TRUNC(sysdate)
and tgt.src_id = src.id)
WHERE DECODE(src.name, tgt.name, 0,1)>0;

select * from cls_table;

commit;

MERGE INTO target_table tgt
USING (SELECT * FROM cls_table) src
ON (src.id = tgt.src_id 
AND src.start_dt = tgt.start_dt)
WHEN MATCHED THEN 
UPDATE SET tgt.name = src.name,
tgt.end_dt = src.end_dt
WHEN NOT MATCHED THEN 
INSERT (id, src_id, name, start_dt, end_dt)
VALUES (test_table.nextval, src.id, src.name, src.start_dt, src.end_dt);

commit;

select * from target_table;

------------- 3 -----------------

select * from source_table;

truncate table cls_table;

INSERT INTO cls_table 
SELECT src.id, src.name, NVL2(tgt.src_id, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt, TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
FROM source_table src left join target_table tgt
ON (tgt.start_dt<= TRUNC(sysdate)
and tgt.end_dt > TRUNC(sysdate)
and tgt.src_id = src.id)
WHERE DECODE(src.name, tgt.name, 0,1)>0
UNION ALL
SELECT tgt.src_id, tgt.name, tgt.start_dt, TRUNC(sysdate) end_dt
FROM source_table src join target_table tgt
ON (tgt.start_dt<= TRUNC(sysdate)
and tgt.end_dt > TRUNC(sysdate)
and tgt.src_id = src.id)
WHERE DECODE(src.name, tgt.name, 0,1)>0;

SELECT * FROM cls_table;

MERGE INTO target_table tgt
USING (SELECT * FROM cls_table) src
ON (src.id = tgt.src_id 
AND src.start_dt = tgt.start_dt)
WHEN MATCHED THEN 
UPDATE SET tgt.name = src.name,
tgt.end_dt = src.end_dt
WHEN NOT MATCHED THEN 
INSERT (id, src_id, name, start_dt, end_dt)
VALUES (test_table.nextval, src.id, src.name, src.start_dt, src.end_dt);

commit;

select * from target_table;