CREATE OR REPLACE PACKAGE pkg_etl_insert_sizes
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_bras;
  PROCEDURE insert_table_panties;
						
END pkg_etl_insert_sizes;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_sizes
AS
---------------------------------------------------  
PROCEDURE insert_table_bras
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_bra_sizes');
  INSERT INTO cls_bra_sizes (
                              bra_size_uk,
                              bra_size_usa,
                              bra_size_eu,
                              bra_size_fr,
                              bra_size_uie
                            )
  SELECT bra_size_uk,
         bra_size_usa,
         bra_size_eu,
         bra_size_fr,
         bra_size_uie 
  FROM wrk_bra_sizes;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_bras;
---------------------------------------------------  
PROCEDURE insert_table_panties
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_panty_sizes');
  INSERT INTO cls_panty_sizes (
                              panty_size_uk,
                              panty_size_usa,
                              panty_size_eu,
                              panty_size_fr,
                              panty_size_uie
                            )
  SELECT panty_size_uk,
         panty_size_usa,
         panty_size_eu,
         panty_size_fr,
         panty_size_uie 
  FROM wrk_panty_sizes;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END insert_table_panties;
---------------------------------------------------  

END pkg_etl_insert_sizes;