EXPLAIN PLAN FOR
UPDATE /*+ PARALLEL(a) */ sales_by_customers a
SET receipts_sum = receipts_sum * 1.1 
WHERE country = 'India' AND age_category IN
  (SELECT age_category FROM BL_DM.DIM_CUSTOMERS_SCD WHERE region = 'Caribbean');
  
SELECT * FROM TABLE (dbms_xplan.display);