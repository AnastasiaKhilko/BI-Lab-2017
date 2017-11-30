CREATE
  TABLE cstmr10 AS
SELECT
  rownum AS CUST_ID,
  CUST_FIRST_NAME,
  CUST_LAST_NAME,
  CUST_GENDER,
  CUST_YEAR_OF_BIRTH,
  CUST_MARITAL_STATUS,
  CUST_STREET_ADDRESS,
  CUST_POSTAL_CODE,
  CUST_CITY,
  CUST_CITY_ID,
  CUST_STATE_PROVINCE,
  CUST_STATE_PROVINCE_ID,
  COUNTRY_ID,
  CUST_MAIN_PHONE_NUMBER,
  CUST_INCOME_LEVEL,
  CUST_CREDIT_LIMIT,
  CUST_EMAIL,
  CUST_TOTAL,
  CUST_TOTAL_ID,
  CUST_SRC_ID,
  CUST_EFF_FROM,
  CUST_EFF_TO,
  CUST_VALID
FROM
  cstmr c,
  (
    SELECT
      1
    FROM
      dual
      CONNECT BY level<=10
  );
  
  select max (cust_id) from cstmr10;
  
  
  
CREATE
  TABLE sls10 AS
SELECT
  PROD_ID,
  round(dbms_random.value(0,555000)) as CUST_ID,
  TIME_ID,
  CHANNEL_ID,
  PROMO_ID,
  QUANTITY_SOLD,
  AMOUNT_SOLD
FROM
  sls s,
  (
    SELECT
      1
    FROM
      dual
      CONNECT BY level<=4
  );
  
  SELECT
  /*+ parallel(s 32) parallel(c 32) */
  COUNT(*)
FROM
  sls10 s,
  cstmr10 c
WHERE
  s.CUST_ID = c.CUST_ID;
  
  
  
CREATE
  TABLE sls10_part parallel 4 partition BY hash
  (
    cust_id
  )
  (
    PARTITION part1,
    PARTITION part2,
    PARTITION part3,
    PARTITION part4
  ) AS
SELECT
  *
FROM
  sls10;
CREATE
  TABLE cstmr10_part parallel 4 partition BY hash
  (
    cust_id
  )
  (
    PARTITION part1,
    PARTITION part2,
    PARTITION part3,
    PARTITION part4
  ) AS
SELECT
  *
FROM
  cstmr10;
SELECT
  /*+ parallel(s 4) parallel(c 4) */
  COUNT(*)
FROM
  sls10_part s,
  cstmr10_part c
WHERE
  s.CUST_ID = c.CUST_ID;
