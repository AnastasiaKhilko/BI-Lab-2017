-- SMALL/Deps
DROP TABLE deps;
CREATE TABLE deps AS 
SELECT * FROM (SELECT 
                  department_id/10 as department_id, 
                  department_name, 
                  manager_id 
              FROM hr.departments);
SELECT department_id FROM deps;

ALTER TABLE deps 
ADD PRIMARY KEY (department_id);


-- LARGE/Emps   
DROP TABLE emps;   
CREATE TABLE emps AS
 SELECT TRUNC( rownum  ) id, 
 rpad( rownum,100)*2 t_pad, 
 dbms_random.string('A', 10) name, ROUND(dbms_random.value(1,27),0) department_id
   FROM dual
CONNECT BY rownum < 100000;

DROP INDEX department_id;
CREATE INDEX department_id ON emps(department_id);
SELECT * FROM emps;