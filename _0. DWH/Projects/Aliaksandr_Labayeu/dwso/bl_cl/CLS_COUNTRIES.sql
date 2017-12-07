-- CLS_COUNTRIES
execute pkg_drop.DROP_proc('CLS_COUNTRIES','table');
CREATE TABLE CLS_COUNTRIES (
  country_code2 VARCHAR2(10),
  country_code3 VARCHAR2(10),
  country_name VARCHAR2(100),
  subregion_code VARCHAR(4),
  "UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
  );