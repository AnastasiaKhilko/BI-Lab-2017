--drop TABLE Date_Part;

CREATE TABLE Date_Part_Hash (
  date_key_column date PRIMARY KEY,
  string_col VARCHAR2(20),
  real_col number(8,2)
  )
  PARTITION BY HASH (date_key_column)
  (
  PARTITION pr1,
  PARTITION pr2,
  PARTITION pr3
  );
  
    declare 
    cnt INT := 0;
    begin
    FOR cnt IN 0..1000 LOOP
    insert into Date_Part_Hash VALUES (TO_DATE('01-01-2016', 'DD-MM-YYYY')+cnt, 
          to_char(( TO_DATE('01-01-2016', 'DD-MM-YYYY')+cnt),'Month'), 
          cast (cnt/2 as number(8,2)));
    END LOOP;
    END;
  /
 -- ROLLBACK;
  select * from Date_Part_Hash;
  commit;
  
  SELECT count(*) FROM Date_Part_Hash PARTITION(pr1)
  union all
  SELECT count(*) FROM Date_Part_Hash PARTITION(pr2)
  union all
  SELECT count(*) FROM Date_Part_Hash PARTITION(pr3);

  SELECT * FROM Date_Part_Hash PARTITION(pr1) order by 1 ;
  
  select table_name, partition_name, high_value from USER_TAB_PARTITIONS  
  where table_name ='DATE_PART_HASH';
  
/*  ALTER TABLE Date_Part_Hash ADD PARTITION pr4;*/
 
 ALTER TABLE Date_Part_Hash COALESCE PARTITION; 
 
 	ALTER TABLE Date_Part_Hash TRUNCATE PARTITION(pr1);
  
 
  select * from Date_Part
  order by 1;