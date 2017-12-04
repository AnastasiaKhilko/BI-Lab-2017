--PARALLEL DDL.
EXPLAIN PLAN FOR 
CREATE TABLE Customers
PARALLEL 5
AS
SELECT cust_first_name, cust_last_name, cust_email
FROM SH.CUSTOMERS ;


SELECT * FROM TABLE (dbms_xplan.display);
