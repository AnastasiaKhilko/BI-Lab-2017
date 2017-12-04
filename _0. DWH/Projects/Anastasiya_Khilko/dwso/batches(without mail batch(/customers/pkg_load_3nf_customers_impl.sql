CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_customers AS
    PROCEDURE load_wrk_customers
    IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_customers';
        INSERT INTO wrk_customers SELECT
            *
        FROM
            sa_src.ext_customers;
        COMMIT;
        --dbms_output.put_line('The data in the table WRK_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_customers;
/****************************************************/

PROCEDURE load_cls_customers
    IS
CURSOR c_cust
    IS
  SELECT src.code,src.last_name, src.first_name,
  src.age, src.email, src.phone, src.address_id,
  NVL2(tgt.code, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt, TO_DATE('31/12/9999','DD/MM/YYYY') end_dt, 'Y' isactive
  FROM WRK_CUSTOMERS src left join BL_3NF.CE_CUSTOMERS tgt
  ON (tgt.start_dt<= TRUNC(sysdate)
  and tgt.end_dt > TRUNC(sysdate)
  and tgt.code = src.code)
  WHERE (DECODE(src.last_name, tgt.last_name, 0,1)+ DECODE(src.first_name, tgt.first_name, 0,1) +
    DECODE(src.age, tgt.age, 0,1)+ DECODE(src.email, tgt.email, 0,1) + DECODE(src.phone, tgt.phone, 0,1)+ DECODE(src.address_id, tgt.address_id, 0,1))>0
  union all
  SELECT tgt.code, tgt.last_name, tgt.first_name,
  tgt.age, tgt.email, tgt.phone, tgt.address_id,
  tgt.start_dt, TRUNC(sysdate) end_dt, 'N' is_active
  FROM WRK_CUSTOMERS src join BL_3NF.CE_CUSTOMERS tgt
  ON (tgt.start_dt<= TRUNC(sysdate)
  and tgt.end_dt > TRUNC(sysdate)
  and tgt.code = src.code)
  WHERE (DECODE(src.last_name, tgt.last_name, 0,1)+ DECODE(src.first_name, tgt.first_name, 0,1) +
    DECODE(src.age, tgt.age, 0,1)+ DECODE(src.email, tgt.email, 0,1) + DECODE(src.phone, tgt.phone, 0,1) + DECODE(src.address_id, tgt.address_id, 0,1))>0;

rec_cust cls_customers%rowtype;      
        
BEGIN
EXECUTE IMMEDIATE 'truncate table cls_customers'; 
OPEN c_cust;
  LOOP
    FETCH c_cust INTO rec_cust;
   IF c_cust%found THEN
      INSERT INTO cls_customers (code, last_name, first_name,
      age, email,phone, address_id, start_dt, end_dt, isactive)
      values (rec_cust.code, rec_cust.last_name, rec_cust.first_name, 
      rec_cust.age, rec_cust.email, rec_cust.phone, rec_cust.address_id,
      rec_cust.start_dt, rec_cust.end_dt, rec_cust.isactive);
    END IF;
    EXIT WHEN c_cust%notfound;
  END LOOP; 
  COMMIT;
  CLOSE c_cust;
        --dbms_output.put_line('The data in the table CLS_CUSTOMERS is loaded successfully!');
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_cls_customers;

    
/****************************************************/
PROCEDURE load_ce_customers
    IS
BEGIN
  MERGE INTO BL_3NF.CE_CUSTOMERS tgt
  USING (SELECT code,
    last_name,
    first_name,
    age,
    email,
    phone,
    address_id,
    start_dt,
    end_dt,
    isactive
    FROM cls_customers) src
  ON (src.code = tgt.code 
  AND src.start_dt = tgt.start_dt)
  WHEN MATCHED THEN 
  UPDATE SET
    tgt.end_dt=src.end_dt,
    tgt.isactive=src.isactive
  WHEN NOT MATCHED THEN 
  INSERT (customer_id, code, last_name, first_name, age,
    email, phone, address_id, start_dt, end_dt, isactive)
  VALUES (bl_3nf.seq_customers.nextval, src.code, src.last_name, src.first_name, src.age,
    src.email, src.phone, src.address_id, src.start_dt, src.end_dt, src.isactive);
    COMMIT;
    --dbms_output.put_line('The data in the table CE_CUSTOMERS is loaded successfully!');
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_ce_customers;

/****************************************************/

END pkg_load_3nf_customers;
/