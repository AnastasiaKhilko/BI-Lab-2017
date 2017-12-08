-- CLS_ADDRESSES
execute pkg_drop.DROP_proc('CLS_ADDRESSES','table');
CREATE TABLE CLS_ADDRESSES
(
	"ADDRESS_CODE" VARCHAR2(50),
	"ADDRESS" VARCHAR2(50),
	"POSTAL_CODE" VARCHAR2(50),
	"PHONE" VARCHAR2(50),
	"CITY_CODE" VARCHAR2(30),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
)
;