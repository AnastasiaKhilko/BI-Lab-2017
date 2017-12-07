-- CLS_CITIES
execute pkg_drop.DROP_proc('CLS_CITIES','table');
CREATE TABLE CLS_CITIES (
  city_code VARCHAR2(30),
  city_name VARCHAR2(100),
  country_code VARCHAR2(50),
  "UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
)
;