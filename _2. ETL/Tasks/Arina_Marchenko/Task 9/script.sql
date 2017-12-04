CREATE MATERIALIZED VIEW mv
BUILD IMMEDIATE 
refresh force on demand 
as SELECT 
* 
FROM bl_dm.dim_customers;

INSERT into bl_dm.dim_customers values (50001,
                                  49177,
                                  87965,
                                  'Arina',
                                  'Marchenko',
                                  20,
                                  'female',
                                  '5698 20 78 98',
                                  'arina_marchenko@epam.com',
                                  SYSDATE);

EXECUTE DBMS_MVIEW.REFRESH ('MV');
                                  
SELECT * 
FROM bl_dm.dim_customers
ORDER BY customer_did DESC;

CREATE MATERIALIZED VIEW LOG ON bl_dm.dim_customers
WITH ROWID, SEQUENCE(dim_customers_seq) INCLUDING NEW VALUES;


INSERT into dim_customers values (50002,
                                  49178,
                                  87952,
                                  'Slava',
                                  'Marchenko',
                                  18,
                                  'male',
                                  '5698 96 78 98',
                                  'slava_marchenko@gmail.com',
                                  SYSDATE);

