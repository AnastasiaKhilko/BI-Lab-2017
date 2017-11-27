------------------ Procedure DML INSERT  
-- EXECUTE pkg_system.table_reinsert();
CREATE OR REPLACE PACKAGE pkg_system
  AUTHID CURRENT_USER as
  PROCEDURE table_reinsert;
END pkg_system;
/

CREATE OR REPLACE PACKAGE BODY pkg_system AS 
  PROCEDURE table_reinsert AS
    BEGIN
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_geo_cntr2structure');
      EXECUTE IMMEDIATE ('INSERT INTO cls_geo_cntr2structure SELECT * FROM wrk_GEO_cntr2structure');  
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_geo_countries');
      EXECUTE IMMEDIATE ('INSERT INTO cls_geo_countries SELECT * FROM wrk_GEO_countries');
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_geo_structure');
      EXECUTE IMMEDIATE ('INSERT INTO cls_geo_structure SELECT * FROM wrk_GEO_STRUCTURE');
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_products');
      EXECUTE IMMEDIATE ('INSERT INTO cls_products SELECT * FROM wrk_PRODUCTS');
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_consumers');
      EXECUTE IMMEDIATE ('INSERT INTO cls_consumers SELECT * FROM wrk_CONSUMERS');
  
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_departments');
      EXECUTE IMMEDIATE ('INSERT INTO cls_departments SELECT * FROM wrk_DEPARTMENTS');
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_promotions'); --
      EXECUTE IMMEDIATE ('INSERT INTO cls_promotions SELECT * FROM wrk_PROMOTIONS');
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_sales');
      EXECUTE IMMEDIATE ('INSERT INTO cls_sales SELECT * FROM wrk_SALES');
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_payments');
      EXECUTE IMMEDIATE ('INSERT INTO cls_payments SELECT * FROM wrk_PAYMENTS');
      
      COMMIT;
    END;
END pkg_system;
/
