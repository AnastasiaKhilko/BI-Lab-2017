DROP
  TABLE dim_customers;
CREATE
  TABLE dim_customers
  (
    customer_id NUMBER PRIMARY KEY,
    first_name  VARCHAR2(15),
    last_name   VARCHAR2(15),
    email       VARCHAR2(10),
    phone       VARCHAR2(20)
  );
INSERT
INTO
  dim_customers
  (
    customer_id,
    first_name,
    last_name,
    email,
    phone
  )
SELECT
  EMPLOYEE_ID - 100 +1,
  FIRST_NAME,
  LAST_NAME,
  EMAIL,
  PHONE_NUMBER
FROM
  hr.employees;
SELECT
  *
FROM
  dim_customers;
DROP
  TABLE dim_locations;
CREATE
  TABLE dim_locations
  (
    location_id    NUMBER PRIMARY KEY,
    city           VARCHAR2(35),
    postal_code    VARCHAR2(15),
    street_address VARCHAR2(75),
    country        VARCHAR2(35),
    region         VARCHAR2(20)
  );
DROP
  sequence loc_id;
CREATE SEQUENCE loc_id MINVALUE 1 MAXVALUE 25 START WITH 1 INCREMENT BY 1;
  INSERT
  INTO
    dim_locations
    (
      location_id ,
      city,
      postal_code,
      street_address,
      country,
      region
    )
  SELECT
    loc_id.nextval ,
    city,
    postal_code,
    street_address,
    country_name,
    region_name
  FROM
    hr.locations loc
  LEFT JOIN hr.countries cn
  ON
    loc.country_id = cn.country_id
  LEFT JOIN hr.regions r
  ON
    cn.region_id = r.region_id;
  SELECT
    *
  FROM
    dim_locations;
  SELECT
    *
  FROM
    dim_date;
  COMMIT;
  DROP
    TABLE dim_date;
  CREATE
    TABLE dim_date AS
  SELECT
    CurrDate                       AS Date_ID,
    TO_CHAR(CurrDate,'YYYYMMDD')   AS date_line,
    TO_CHAR(CurrDate,'DD.MM.YYYY') AS date_format,
    TO_CHAR(CurrDate,'Day')        AS Week_Day_Full,
    TO_CHAR(CurrDate,'DY')         AS Week_Day_Short,
    TO_NUMBER(TRIM(leading '0'
  FROM
    TO_CHAR(CurrDate,'D'))) AS Day_Num_of_Week,
    TO_NUMBER(TRIM(leading '0'
  FROM
    TO_CHAR(CurrDate,'DD'))) AS Day_Num_of_Month,
    TO_NUMBER(TRIM(leading '0'
  FROM
    TO_CHAR(CurrDate,'DDD'))) AS Day_Num_of_Year,
    UPPER(TO_CHAR(CurrDate,'Mon')
    || '-'
    || TO_CHAR(CurrDate,'YYYY')) AS Month_ID,
    -- 31 AS Month_Time_Span,
    --MAX(TO_NUMBER(TO_CHAR(CurrDate, 'DD'))) OVER (PARTITION BY TO_CHAR(
    -- CurrDate
    -- ,'Mon')) AS Month_Time_Span,
    --to_date('31-JAN-2010','DD-MON-YYYY') AS Month_End_Date,
    --MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'Mon')) as
    -- Month_End_Date
    -- ,
    --TO_CHAR(CurrDate,'Mon') || ' ' || TO_CHAR(CurrDate,'YYYY') AS
    -- Month_Short_Desc,
    --TRIM(TO_CHAR(CurrDate,'Month')) || ' ' || TO_CHAR(CurrDate,'YYYY') AS
    -- Month_Long_Desc,
    TO_CHAR (CurrDate,'Mon')  AS Month_Short,
    TO_CHAR(CurrDate,'Month') AS Month_Long,
    TO_NUMBER(TRIM(leading '0'
  FROM
    TO_CHAR(CurrDate,'MM'))) AS Month_Num_of_Year,
    'Q'
    || UPPER(TO_CHAR(CurrDate,'Q')
    || '-'
    || TO_CHAR(CurrDate,'YYYY')) AS Quarter_ID,
    'Q'
    || UPPER(TO_CHAR(CurrDate,'Q')) AS Quarter,
    -- 31 AS Quarter_Time_Span,
    --COUNT(*) OVER (PARTITION BY TO_CHAR(CurrDate,'Q')) AS Quarter_Time_Span,
    -- to_date('31-JAN-2010','DD-MON-YYYY') AS Quarter_End_Date,
    --MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'Q')) AS
    -- Quarter_End_Date
    -- ,
    TO_NUMBER(TO_CHAR(CurrDate,'Q')) AS Quarter_Num_of_Year,
    TO_CHAR(CurrDate,'YYYY')         AS Year_ID
    --31 AS Year_Time_Span,
    --COUNT(*) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYY')) AS Year_Time_Span,
    -- to_date('31-JAN-2010','DD-MON-YYYY') AS Year_End_Date
    --MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYY')) Year_End_Date
  FROM
    (
      SELECT
        level n,
        -- Calendar starts at the day after this date.
        TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(level,'day')
        CurrDate
      FROM
        dual
        -- Change for the number of days to be added to the table.
        CONNECT BY level <= 11000
    )
  ORDER BY
    CurrDate;
  ALTER TABLE dim_date ADD CONSTRAINT pk_date_id PRIMARY KEY (date_id);
  COMMIT;
  SELECT
    *
  FROM
    dim_date;
  DROP
    TABLE fact_order;
  CREATE
    TABLE fact_order
    (
      order_id    NUMBER PRIMARY KEY,
      customer_id NUMBER REFERENCES dim_customers(customer_id),
      location_id NUMBER REFERENCES dim_locations(location_id),
      date_id     DATE REFERENCES dim_date(Date_ID),
      amount      NUMBER,
      discount    NUMBER
    ) ;
  DROP
    sequence order_id;
CREATE SEQUENCE order_id MINVALUE 1 MAXVALUE 100000 START WITH 1 INCREMENT BY 1
  ;
  INSERT
  INTO
    fact_order
    (
      order_id,
      customer_id ,
      location_id,
      date_id,
      amount,
      discount
    )
  SELECT
    order_id.nextval,
    ROUND ( ABS ( dbms_random.normal *
    (
      SELECT
        COUNT ( * )
      FROM
        DIM_customers
    )
    /5) + dbms_random.value ( 0.51,
    (
      SELECT
        COUNT ( * )
      FROM
        DIM_customers
    )
    *2/5 ) ) AS customer_id,
    --round(dbms_random.value ( 0.51, (SELECT COUNT ( * ) FROM DIM_customers )
    -- )),
    --round ( 0.51 + ABS ( dbms_random.normal * (SELECT COUNT ( * ) FROM
    -- DIM_locations )/3  +
    --dbms_random.value ( (SELECT COUNT ( * ) FROM DIM_locations )/3, (SELECT
    -- COUNT ( * ) FROM DIM_locations )*2/3 ) )) AS location_id,
    ROUND(dbms_random.value ( 0.51,
    (
      SELECT
        COUNT ( * )
      FROM
        DIM_locations
    )
    ) ),
    TRUNC ( sysdate                                + dbms_random.value ( -1500, 1500 ) ),
    ABS( ROUND ( dbms_random.value ( 70, 800 )     + dbms_random.normal*100 -
    dbms_random.normal                             *10 ) ) AS amount,
    ROUND( ABS ( dbms_random.value ( 0.01, 60.49 ) - dbms_random.value ( 0.01,
    60.49 ) ), 2 ) AS discount
  FROM
    dual
    CONNECT BY level <= 2000;
  COMMIT;
  SELECT
    *
  FROM
    fact_order;
