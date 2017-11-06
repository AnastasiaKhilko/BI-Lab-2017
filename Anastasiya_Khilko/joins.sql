--hash outer join

SELECT loc.LOCATION_ID, loc.CITY, dep.DEPARTMENT_ID, dep.DEPARTMENT_NAME
FROM LOCATIONS loc
LEFT JOIN DEPARTMENTS dep ON loc.LOCATION_ID = dep.LOCATION_ID;

--merge join

SELECT loc.LOCATION_ID, loc.CITY, dep.DEPARTMENT_ID, dep.DEPARTMENT_NAME
FROM LOCATIONS loc
INNER JOIN DEPARTMENTS dep ON loc.LOCATION_ID = dep.LOCATION_ID;

--nested loops

SELECT loc.LOCATION_ID, loc.CITY, dep.DEPARTMENT_ID, dep.DEPARTMENT_NAME
FROM LOCATIONS loc
INNER JOIN DEPARTMENTS dep ON loc.LOCATION_ID = dep.LOCATION_ID
where city = 'Oxford';

--hash join

select dep.DEPARTMENT_ID, emp.EMAIL
from EMPLOYEES emp, DEPARTMENTS dep
where emp.department_id = dep.department_id;

-- left outer + right
select emp.PHONE_NUMBER, JOB_TITLE
FROM employees emp
left join JOBS j ON emp.JOB_ID = j.JOB_ID ;

select emp.PHONE_NUMBER, JOB_TITLE
FROM employees emp, JOBS j
where emp.JOB_ID(+) = j.JOB_ID;

select emp.PHONE_NUMBER, JOB_TITLE
FROM employees emp, JOBS j
where emp.JOB_ID = j.JOB_ID(+);

--full outer
select emp.PHONE_NUMBER, JOB_TITLE
FROM employees emp
full join JOBS j ON emp.JOB_ID = j.JOB_ID ;

select emp.PHONE_NUMBER, JOB_TITLE
FROM employees emp, JOBS j
where emp.JOB_ID(+) = j.JOB_ID
union all
select emp.PHONE_NUMBER, JOB_TITLE
FROM employees emp, JOBS j
where emp.JOB_ID = j.JOB_ID(+);

--
select emp.PHONE_NUMBER, JOB_TITLE
FROM employees emp, JOBS j
where emp.JOB_ID = j.JOB_ID(+);
