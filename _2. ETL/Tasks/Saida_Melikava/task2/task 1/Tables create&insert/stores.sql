CREATE TABLE stores
  (
    store_id       NUMBER(8) NOT NULL,
    store_code     VARCHAR2(10) NOT NULL,
    store_name     VARCHAR2(10) NOT NULL,
    email          VARCHAR2(60) NOT NULL,
    phone          VARCHAR2(20) NOT NULL,
    country_sur_id NUMBER(8) NOT NULL
  );
CREATE SEQUENCE seq_store INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  INSERT INTO stores
  SELECT seq_store.nextval,
    store_code,
    store_name,
    email,
    phone,
    country_id
  FROM
    (SELECT n                       AS store_id,
      dbms_random.string ( 'X', 6 ) AS store_code,
      'store'
      ||n AS store_name,
      'MIF'
      ||n
      ||'@'
      ||
      CASE( ROUND( dbms_random.value(1,6)))
        WHEN 1
        THEN 'google.com'
        WHEN 2
        THEN 'gmail.com'
        WHEN 3
        THEN 'mail.ru'
        WHEN 4
        THEN 'yandex.ru'
        WHEN 5
        THEN 'yahoo.com'
        WHEN 6
        THEN 'zoho.com'
      END AS email,
      ROUND( dbms_random.value(100,999))
      ||'-'
      ||ROUND( dbms_random.value(100,999))
      ||'-'
      ||ROUND( dbms_random.value(100,999)) AS phone,
      ROUND( dbms_random.value(
      (SELECT MIN(country_sur_id) FROM test_ce_countries
      ),
      (SELECT MAX(country_sur_id) FROM test_ce_countries
      ))) AS country_id
    FROM
      ( SELECT level n FROM dual CONNECT BY level <= 10
      )
    );
  COMMIT;
  SELECT * FROM stores;
