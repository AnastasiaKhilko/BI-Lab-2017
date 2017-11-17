drop TABLE Date_Part;

CREATE TABLE Date_Part (
  date_key_column date PRIMARY KEY,
  string_col VARCHAR2(20),
  real_col number(8,2)
  )
  PARTITION BY RANGE (date_key_column)
  (
  PARTITION pr1 VALUES LESS THAN (TO_DATE('01-01-2017', 'DD-MM-YYYY')),
  PARTITION pr2 VALUES LESS THAN (TO_DATE('01-01-2018', 'DD-MM-YYYY')),
  PARTITION pr3 VALUES LESS THAN (MAXVALUE)
  );
  
    declare 
    cnt INT := 0;
    begin
    FOR cnt IN 0..1000 LOOP
    insert into Date_Part VALUES (TO_DATE('01-01-2016', 'DD-MM-YYYY')+cnt, 
          to_char(( TO_DATE('01-01-2016', 'DD-MM-YYYY')+cnt),'Month'), 
          cast (cnt/2 as number(8,2)));
    END LOOP;
    END;
  /
 -- ROLLBACK;
  select * from Date_Part;
  commit;
  
  SELECT count(*) FROM Date_Part PARTITION(pr1);
  SELECT count(*) FROM Date_Part PARTITION(pr2);
  SELECT count(*) FROM Date_Part PARTITION(pr3);

  SELECT * FROM Date_Part PARTITION(pr3) order by 1 ;
  
  select table_name, partition_name, high_value from USER_TAB_PARTITIONS  
  where table_name ='DATE_PART';
  
  ALTER TABLE Date_Part MERGE PARTITIONS pr1, pr2 INTO PARTITION pr2;
  
  ALTER TABLE Date_Part SPLIT PARTITION pr2 AT (TO_DATE('01-01-2017', 'DD-MM-YYYY')) INTO (PARTITION pr1, PARTITION pr2);
  
  ALTER TABLE Date_Part DROP PARTITION pr1;
  
  select * from Date_Part
  order by 1;