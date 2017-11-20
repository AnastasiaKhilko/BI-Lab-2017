DROP TABLE test_ce_countries;
CREATE TABLE test_ce_countries
  (
    country_sur_id NUMBER(8) PRIMARY KEY,
    country_id     NUMBER(10) NOT NULL,
    country_desc   VARCHAR2(200) NOT NULL,
    countre_code   VARCHAR2(3)
  );
CREATE SEQUENCE seq_countries INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  INSERT
  INTO test_ce_countries
    (
      country_sur_id,
      country_id,
      country_desc,
      countre_code
    )
  SELECT seq_countries.nextval,
    country_id,
    country_desc,
    country_code
  FROM
    (SELECT countries.country_id AS country_id ,
      countries.country_desc     AS country_desc,
      countries.country_code     AS country_code
    FROM countries
    );
  COMMIT;
  SELECT * FROM test_ce_countries;
