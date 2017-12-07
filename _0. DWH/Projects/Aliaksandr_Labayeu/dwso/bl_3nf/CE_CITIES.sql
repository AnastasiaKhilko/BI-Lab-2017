-- CE_CITIES
execute pkg_drop.DROP_proc('"BL_3NF"."CE_CITIES"','table');
CREATE TABLE "BL_3NF"."CE_CITIES"
(
	"CITY_ID" NUMBER(8,2) NOT NULL,
	"CITY_CODE" VARCHAR2(30),
	"CITY_NAME" VARCHAR2(50),
	"COUNTRY_ID" NUMBER(8,2),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
)
;

execute pkg_drop.DROP_proc('seq_cities','sequence');
CREATE SEQUENCE seq_cities
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;