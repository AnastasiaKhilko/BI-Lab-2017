-- Coalescing partition.
ALTER TABLE PT_EMPLOYEES_HASH COALESCE PARTITION PARALLEL 2;

-- Dropping partition.
ALTER TABLE PT_EMPLOYEES_LIST DROP PARTITION PT_2;

-- Merging partitions.
ALTER TABLE PT_EMPLOYEES_LIST MERGE PARTITIONS PT_1, PT_3 INTO PARTITION PT_0;

-- Moving partition.   

-- Checking tablespace of the partition.   
SELECT PARTITION_NAME, TABLESPACE_NAME
FROM ALL_TAB_PARTITIONS
WHERE PARTITION_NAME LIKE 'PT_0';

-- Giving user a grant on using another tablespace.
ALTER USER HR quota unlimited on EXAMPLE;

-- Moving partition to another tablespace.   
ALTER TABLE PT_EMPLOYEES_LIST 
  MOVE PARTITION PT_0 
   TABLESPACE EXAMPLE;
   
-- Checking tablespace of the partition.   
SELECT PARTITION_NAME, TABLESPACE_NAME
FROM ALL_TAB_PARTITIONS
WHERE PARTITION_NAME LIKE 'PT_0';

-- Truncating partition.
ALTER TABLE PT_EMPLOYEES_LIST TRUNCATE PARTITION PT_0;

-- Analyzing partition. 
SELECT * 
FROM user_tab_partitions;
--WHERE table_name = 'PT_EMPLOYEES_RANGE';