--on demand
CREATE MATERIALIZED VIEW matview_1 BUILD IMMEDIATE refresh force ON demand
AS
  SELECT * FROM bl_3nf.ce_customer;
  SELECT* FROM matview_1;
  
  INSERT
  INTO bl_3nf.ce_customer VALUES
    (
      '600000',
	  'Mikita',
	  'mt',
	  'Tur',
	  '19',
	  'M',
	  'Mikita_Tur@epam.com',
	  '6568282',
	  '38225'
    );
 commit;   
    
    
EXECUTE DBMS_MVIEW.REFRESH ('MV_1');


select * from mv_1 
order by 1;

CREATE MATERIALIZED VIEW LOG ON bl_3nf.ce_customer
WITH ROWID, SEQUENCE(cust_seq) INCLUDING NEW VALUES;

--ON_COMMIT.
CREATE MATERIALIZED VIEW mv_2 REFRESH ON COMMIT
AS
  SELECT * FROM bl_3nf.ce_customer;
 
 
  INSERT
  INTO bl_3nf.ce_customer VALUES
    (
      '999999999',
	  'Kseniya',
	  'kt',
	  'Tur',
	  '13',
	  'F',
	  'blenattebaby@gmail.com',
	  '5568282',
	  '38225'
    );
 commit;  
  
  SELECT* FROM mv_2 order by 1;    