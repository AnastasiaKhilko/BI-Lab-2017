--on demand
CREATE MATERIALIZED VIEW mv_1 BUILD IMMEDIATE refresh force ON demand
AS
  SELECT * FROM bl_3nf.ce_customers;
  SELECT* FROM mv_1;
  
  INSERT
  INTO bl_3nf.ce_customers VALUES
    (
      '29',
      '2145787878777',
      'Aksana',
      'Kuratnik',
      '20',
      'Aksana_Kuratnik@epa./com',
      '958-06-75',
      '30 Kozyrevskaya',
      '24 Tushi',
      sysdate,
      '31-DEC-99',
      'TRUE'
    );
 commit;   
    
    
EXECUTE DBMS_MVIEW.REFRESH ('MV_1');


select * from mv_1 
order by 1;

CREATE MATERIALIZED VIEW LOG ON bl_3nf.ce_customers
WITH ROWID, SEQUENCE(customer_id) INCLUDING NEW VALUES;

--ON_COMMIT.
CREATE MATERIALIZED VIEW mv_2 REFRESH ON COMMIT
AS
  SELECT * FROM bl_3nf.ce_customers;
 
 
  INSERT
  INTO bl_3nf.ce_customers VALUES
    (
      '11',
      '214578782478777',
      'Alice',
      'Smith',
      '20',
      'Alice@gmail.com',
      '958-064-88',
      '320 Karrols',
      '24 Tushi',
      sysdate,
      '31-DEC-99',
      'TRUE'
    );
 commit;  
  
  SELECT* FROM mv_2 order by 1;    