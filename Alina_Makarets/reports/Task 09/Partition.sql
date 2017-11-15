--CREATE AND INSERT 
CREATE TABLE table_partition (
    key_column   NUMBER NOT NULL,
    data_part          DATE
    )
    
    PARTITION BY RANGE ( data_part ) (
        PARTITION part_less_2013
            VALUES LESS THAN ( TO_DATE('01.01.2013','dd.mm.yyyy') ),
        PARTITION part_less_2014
            VALUES LESS THAN ( TO_DATE('01.01.2014','dd.mm.yyyy') ),
        PARTITION part_less_2015
            VALUES LESS THAN ( TO_DATE('01.01.2015','dd.mm.yyyy') ),
        PARTITION part_less_2016
            VALUES LESS THAN ( TO_DATE('01.01.2016','dd.mm.yyyy') ),
        PARTITION part_less_2017
            VALUES LESS THAN ( TO_DATE('01.01.2017','dd.mm.yyyy') ),
        PARTITION part_less_max
            VALUES LESS THAN ( MAXVALUE )
        );

CREATE SEQUENCE key_column_seq
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1;
  
INSERT INTO  table_partition 
SELECT key_column_seq.nextval,
       SYSDATE+rownum-365*4   
FROM dual
CONNECT BY rownum <=365*4;
-------------------------------------------
--DROPPING
ALTER TABLE table_partition DROP PARTITION PART_LESS_MAX;
ALTER TABLE table_partition DROP PARTITION PART_LESS_2017;
-------------------------------------------
--ADDING PARTITION
ALTER TABLE table_partition ADD PARTITION PART_LESS_2017 values less than (to_date('01.01.2017','dd.mm.yyyy'));
-------------------------------------------
--MERGING PARTITION
ALTER TABLE table_partition MERGE PARTITIONS PART_LESS_2015, PART_LESS_2016 into partition PART_LESS_2016;
-------------------------------------------
--MOVING PARTITION
ALTER TABLE table_partition MOVE PARTITION part_less_2013
TABLESPACE users NOLOGGING COMPRESS;
-------------------------------------------
--SPLITTING PARTITION
ALTER TABLE table_partition SPLIT PARTITION PART_LESS_2016 
AT (to_date('01-01-2015', 'DD-MM-YYYY')) INTO (partition PART_LESS_2015, partition PART_LESS_2016);
-------------------------------------------
--TRUNCATE PARTITION
ALTER TABLE table_partition TRUNCATE PARTITION PART_LESS_2014;
-------------------------------------------        
--COALESCING PARTITION
CREATE TABLE table_partition_hash (
    key_column   NUMBER NOT NULL,
    data_part          DATE
    )
    
    PARTITION BY HASH ( data_part ) (
        PARTITION part_less_2013,
        PARTITION part_less_2014,
        PARTITION part_less_2015,
        PARTITION part_less_2016,
        PARTITION part_less_2017,
        PARTITION part_less_max
        );

ALTER TABLE table_partition_hash COALESCE PARTITION;