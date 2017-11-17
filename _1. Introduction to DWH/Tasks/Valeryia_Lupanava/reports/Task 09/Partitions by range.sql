-- Creating table with partitions.
CREATE TABLE PT_EMPLOYEES_RANGE
( EMPLOYEE_ID	NUMBER(6,0),
  JOB_ID	    VARCHAR2(10 BYTE),
  HIRE_DATE	  DATE
 )
 PARTITION BY RANGE(HIRE_DATE)
 (partition PT_1 values less than (to_date('01.01.1990','DD.MM.YYYY')),
  partition PT_2 values less than (to_date('01.01.1995','DD.MM.YYYY')),
  partition PT_3 values less than (to_date('01.01.2000','DD.MM.YYYY')),
  partition PT_OTHER values less than (maxvalue)
 );
 
-- Filling table with data.
INSERT INTO PT_EMPLOYEES_RANGE(EMPLOYEE_ID, JOB_ID, HIRE_DATE)
SELECT      EMPLOYEE_ID, JOB_ID, HIRE_DATE
FROM        EMPLOYEES;

-- Selecting all data from the table.
SELECT *
FROM PT_EMPLOYEES_RANGE;

SELECT COUNT(*) 
FROM PT_EMPLOYEES_RANGE;

-- Selecting 1-st partition data from the table.
SELECT * 
FROM PT_EMPLOYEES_RANGE PARTITION(PT_1);

SELECT COUNT(*) 
FROM PT_EMPLOYEES_RANGE PARTITION(PT_1);

-- Selecting 2-nd partition data from the table.
SELECT * 
FROM PT_EMPLOYEES_RANGE PARTITION(PT_2);

SELECT COUNT(*) 
FROM PT_EMPLOYEES_RANGE PARTITION(PT_2);

-- Selecting 3-rd partition data from the table.
SELECT * 
FROM PT_EMPLOYEES_RANGE PARTITION(PT_3);

SELECT COUNT(*) 
FROM PT_EMPLOYEES_RANGE PARTITION(PT_3);

-- Selecting last partition data from the table.
SELECT * 
FROM PT_EMPLOYEES_RANGE PARTITION(PT_OTHER);

SELECT COUNT(*) 
FROM PT_EMPLOYEES_RANGE PARTITION(PT_OTHER);