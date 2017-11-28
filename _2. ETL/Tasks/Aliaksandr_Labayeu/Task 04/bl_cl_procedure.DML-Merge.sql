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
      MERGE INTO cls_geo_cntr2structure c_cs
      USING wrk_GEO_cntr2structure w_cs
      ON (c_cs.country_id = w_cs.country_id)
      WHEN MATCHED
        THEN UPDATE 
          SET c_cs.country_desc = w_cs.country_desc
      WHEN NOT MATCHED
        THEN INSERT 
        VALUES (
                w_cs.country_id,
                w_cs.country_desc,
                w_cs.structure_code,
                w_cs.structure_desc);
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_geo_countries');
      MERGE INTO cls_geo_countries c_c
      USING wrk_GEO_countries w_c
      ON (c_c.country_code = w_c.country_code)
      WHEN MATCHED
        THEN UPDATE 
          SET c_c.country_desc = w_c.country_desc
      WHEN NOT MATCHED
        THEN INSERT 
          VALUES (
                w_c.country_id,
                w_c.country_desc,
                w_c.country_code);
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_geo_structure');
      MERGE INTO cls_geo_structure c_s
      USING wrk_GEO_STRUCTURE w_s
      ON (c_s.child_code = w_s.child_code AND c_s.parent_code = w_s.parent_code)
      WHEN MATCHED
        THEN UPDATE 
          SET c_s.STRUCTURE_DESC = w_s.STRUCTURE_DESC
      WHEN NOT MATCHED 
        THEN INSERT 
          VALUES (
            w_s.child_code,
            w_s.parent_code,
            w_s.structure_desc,
            w_s.structure_level);
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_products');
      MERGE INTO cls_products c_p
      USING wrk_products w_p
      ON (c_p.product_id = w_p.product_id)
      WHEN MATCHED
        THEN UPDATE 
          SET c_p.product = w_p.product
      WHEN NOT MATCHED
        THEN INSERT
          VALUES (
            w_p.product_id,
            w_p.product,
            w_p.prod_category,
            w_p.subcategory,
            w_p.localization,
            w_p.tobacco,
            w_p.prod_size,
            w_p.prod_price);
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_consumers');
      MERGE INTO cls_consumers c_c
      USING wrk_consumers w_c
      ON (c_c.cons_id = w_c.cons_id)
      WHEN MATCHED 
        THEN UPDATE SET  c_c.consumer_rate = w_c.Consumer_rate
      WHEN NOT MATCHED
        THEN INSERT 
        VALUES (
          w_c.cons_id, 
          w_c.gender, 
            SUBSTR(w_c.FullName, 1, INSTR(w_c.FullName, ' ')-1),
            substr(w_c.fullname, instr(w_c.fullname, ' ', 1, 2)+1,(instr(w_c.fullname, ' ', 1, 2)-instr(w_c.fullname, ' ', 1, 1))),
            substr(w_c.fullname, instr(w_c.fullname, ' ', 1, 2)+1),    
          w_c.StreetAddress, 
          w_c.City,
          w_c.State, 
          w_c.StateFull,
          w_c.ZipCode,
          w_c.Country_CODE,
          w_c.Country,
          w_c.EmailAddress,
          w_c.TelephoneNumber,
          w_c.TelephoneCountryCode,
          w_c.Birthday,
          w_c.Age,
          w_c.CCType,	
          w_c.CCExpires,
          w_c.WesternUnion,
          w_c.Color,
          w_c.Occupation,
          w_c.Company,
          w_c.Consumer_rate );
                            
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_departments');
      MERGE INTO cls_departments c_d
      USING wrk_DEPARTMENTS w_d
      ON (c_d.dep_id = w_d.dep_id)
      WHEN MATCHED
        THEN UPDATE 
          SET c_d.DEPARTMENT = w_d.DEPARTMENT,
              c_d.COUNTRY = w_d.COUNTRY,
              c_d.CITY = w_d.CITY,
              c_d.STREETADDRESS = w_d.STREETADDRESS,
              c_d.STATEFULL = w_d.STATEFULL,
              c_d.STATE_CODE = w_d.STATE_CODE,
              c_d.COUNTRY_CODE = w_d.COUNTRY_CODE,
              c_d.ZIPCODE = w_d.ZIPCODE,
              c_d.UPS = w_d.UPS,
              c_d.TELEPHONENUMBER = w_d.TELEPHONENUMBER
      WHEN NOT MATCHED
        THEN INSERT
          VALUES (
              w_d.DEP_ID, 
              w_d.DEPARTMENT, 
              w_d.COUNTRY, 
              w_d.CITY, 
              w_d.STREETADDRESS, 
              w_d.STATEFULL, 
              w_d.STATE_CODE, 
              w_d.COUNTRY_CODE, 
              w_d.ZIPCODE, 
              w_d.UPS, 
              w_d.TELEPHONENUMBER);
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_promotions'); 
      MERGE INTO cls_promotions c_p
      USING wrk_PROMOTIONS w_p
      ON (c_p.promo_code = w_p.promo_code)
      WHEN MATCHED
        THEN UPDATE 
          SET c_p.PROMO_NAME = w_p.PROMO_NAME, 
              c_p.PROMO_DESC = w_p.PROMO_DESC,  
              c_p.PROMO_COST = w_p.PROMO_COST, 
              c_p.START_DT = w_p.START_DT, 
              c_p.END_DT = w_p.END_DT, 
              c_p.IS_ACTIVE = w_p.IS_ACTIVE
      WHEN NOT MATCHED
        THEN INSERT
          VALUES (
            w_p.PROMO_ID,
            w_p.PROMO_CODE, 
            w_p.PROMO_NAME, 
            w_p.PROMO_DESC, 
            w_p.PROMO_COST, 
            w_p.START_DT, 
            w_p.END_DT, 
            w_p.IS_ACTIVE);
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_sales');
            MERGE INTO cls_sales c_s
      USING wrk_SALES w_s
      ON (c_s.sale_id = w_s.sale_id)
      WHEN MATCHED
        THEN
          UPDATE 
          SET 
            c_s.SALE_DATE = w_s.DATE_ID,
            c_s.DEPARTMENT_ID = w_s.DEPARTMENT_ID,
            c_s.CONSUMER_ID = w_s.CONSUMER_ID,
            c_s.PRODUCT_ID = w_s.PRODUCT_ID,
            c_s.PROMO_ID = w_s.PROMO_ID,
            c_s.PAY_STATE_ID = w_s.PAY_STATE_ID
      WHEN NOT MATCHED
        THEN
          INSERT
            VALUES (
            w_s.SALE_ID, 
            w_s.DATE_ID,
            w_s.DEPARTMENT_ID,
            w_s.CONSUMER_ID,
            w_s.PRODUCT_ID,
            w_s.PROMO_ID,
            w_s.PAY_STATE_ID);
      
      EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_payments');
      MERGE INTO cls_payments c_pm
      USING wrk_PAYMENTS w_pm
      ON (c_pm.payment_id = w_pm.payment_id)
      WHEN MATCHED
        THEN
          UPDATE 
          SET
            c_pm.CONSUMER_ID = w_pm.CONSUMER_ID,
            c_pm.SALE_ID = w_pm.SALE_ID,
            c_pm.DEPARTMENT_ID = w_pm.DEPARTMENT_ID,
            c_pm.COST = w_pm.AMOUNT,
            c_pm.AMOUNT = w_pm.AMOUNT
      WHEN NOT MATCHED
        THEN
          INSERT
            VALUES (
            w_pm.PAYMENT_ID,
            w_pm.CONSUMER_ID,
            w_pm.SALE_ID,
            w_pm.DEPARTMENT_ID,
            w_pm.AMOUNT,
            w_pm.AMOUNT);
      
      -- 3nf
    
      
      
      COMMIT;
    END;
END pkg_system;
/
