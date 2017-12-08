-- CE_COUNTRIES
execute pkg_drop.DROP_proc('"BL_3NF"."CE_COUNTRIES"','table');
CREATE TABLE "BL_3NF"."CE_COUNTRIES"
(
	"COUNTRY_ID" NUMBER(8,2) NOT NULL,
	"COUNTRY_CODE2" VARCHAR2(10),
  "COUNTRY_CODE3" VARCHAR2(10),
	"COUNTRY_NAME" VARCHAR2(100),
	"SUBREGION_ID" NUMBER(8,2),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
)
;

execute pkg_drop.DROP_proc('seq_countries','sequence');
CREATE SEQUENCE seq_countries
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;