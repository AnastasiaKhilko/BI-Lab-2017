create or replace PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
  
PROCEDURE load_wrk_prod_types;
 PROCEDURE insert_table_customers;
PROCEDURE merge_table_ce_customers;
						
END pkg_etl_insert_customers;
/
create or replace PACKAGE BODY pkg_etl_insert_customers
AS
---------------------------------------------------  
PROCEDURE load_wrk_prod_types
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_customers';
        INSERT INTO wrk_customers SELECT
            *
        FROM
            sa_src.ext_customers;
            
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_prod_types;
PROCEDURE insert_table_customers
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_customers');
  INSERT INTO cls_customers (
    CUSTOMER_ID , 
    GENDER , 
    NAME, 
    SURNAME, 
    TITLE, 
    EMAIL , 
    PHONE , 
    AGE , 
    AGE_GROUP , 
    --BIRTHDAY, WF 
    OCCUPATION , 
    COMPANY , 
    address_id, 
  UPDATE_DT
   )
SELECT   --cls_customers_seq.NEXTVAL AS customer_id,
         to_number(number_id) as customer_id,
         Gender,
        --NameSet VARCHAR2 (250 CHAR),
        GivenName,
        Surname,
        Title,
        
        EmailAddress,
       -- Username,
        TelephoneNumber,
       -- Age,
       5,
       'ooo',
      -- to_date(Birthday,'MM/DD/YYYY'), WF
       --to_date(Birthday,'MM/DD/YYYY'),
     
        Occupation,
        Company,
       address_id,
--         (case when age >= 18 and age <25 then 1
--               when age >= 25 and age <35 then 2
--               when age >= 35 and age <45 then 3
--               when age >= 45 and age <55 then 4
--               when age >= 55 then 5
--          end) as age_category_id
       sysdate as UPDATE_DT
  FROM wrk_customers cu left join bl_3nf.ce_addresses ad on cu.streetaddress = ad.address;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_customers;

-----------------------------------------------------  
-----------------------------------------------------
PROCEDURE merge_table_ce_customers
IS
BEGIN

MERGE INTO bl_3nf.ce_customers ce USING
    ( SELECT 
  CUSTOMER_ID, 
	GENDER , 
	NAME, 
	SURNAME, 
	TITLE, 
	EMAIL, 
	PHONE, 
	AGE, 
	AGE_GROUP, 
	--BIRTHDAY, 
	OCCUPATION, 
	COMPANY, 
	address_ID,
	UPDATE_dt
      FROM   cls_customers cust --LEFT JOIN bl_3nf.ce_addresses ad on  cust.zipcode = ad.postal_code
      
    MINUS
      SELECT customer_id,
        gender,
        name,
        surname,
        title,
        email,
        telephone_number,
        age,
        age_group,
      --  birthday,
        occupation,
        company,
        --address_id number references dim_addresses(address_id),
        	address_ID,
        update_dt
             --end_dt,
             --is_active
             --start_dt,
            
      FROM   bl_3nf.ce_customers
    ) cls ON ( ce.customer_id = cls.customer_id )
    WHEN matched THEN
    UPDATE SET --t.end_dt  = c.end_dt,
               --t.is_active = c.is_active
             --  ce.CUSTOMER_ID= cls.CUSTOMER_ID,
	ce.GENDER=cls.GENDER , 
	ce.name = cls.NAME, 
	ce.surname = cls.SURNAME, 
	ce.title = cls.TITLE, 
	ce.email = cls.EMAIL, 
	--ce.phone = cls.PHONE, 
	ce.age = cls.AGE
  --city_id
    WHEN NOT matched THEN
    INSERT
      (
      customer_3nf_id,
        customer_id,
        gender ,
        name ,
        surname,
        title ,
        email ,
        telephone_number,
        age,
        age_group ,
       -- birthday,
        occupation ,
        company,
       address_id,-- number references dim_addresses(address_id),
        update_dt 
        --start_dt,
        --end_dt,
        --is_active
      )
      VALUES
      (
        seq_customers_3nf.NEXTVAL,
       cls.CUSTOMER_ID, 
	cls.GENDER , 
	cls.NAME, 
	cls.SURNAME, 
	cls.TITLE, 
	cls.EMAIL, 
	cls.PHONE, 
	cls.AGE, 
	CLS.AGE_GROUP ,
	--cls.BIRTHDAY, 
	cls.OCCUPATION, 
	cls.COMPANY, 
	cls.ADDRESS_ID, 
	cls.UPDATE_DT
      --  c.start_dt,
        --c.end_dt,
        --c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_customers;

---------------------------------------------------
END pkg_etl_insert_customers;

/
DROP SEQUENCE seq_customers_3nf;
CREATE SEQUENCE seq_customers_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

begin        
--pkg_etl_insert_customers.insert_table_customers;
pkg_etl_insert_customers.load_wrk_prod_types;
pkg_etl_insert_customers.insert_table_customers;
pkg_etl_insert_customers.merge_table_ce_customers;
end;
/

exec pkg_etl_insert_customers.load_wrk_prod_types;
exec pkg_etl_insert_customers.insert_table_customers;
exec pkg_etl_insert_customers.merge_table_ce_customers;
select 
to_date(Birthday,'MM/DD/YYYY')
from wrk_customers;
select * from cls_customers;
truncate table bl_3nf.ce_customers;
select * from  bl_3nf.ce_customers;