-- CE_RESPONSIBLE
execute pkg_drop.DROP_proc('"BL_3NF"."CE_RESPONSIBLE"','table');
CREATE TABLE "BL_3NF"."CE_RESPONSIBLE"
(
	"RESP_ID" NUMBER(8,2) NOT NULL,
	"RESP_CODE" VARCHAR2(50),
	"FIRST_NAME" VARCHAR2(50) DEFAULT ON NULL '-98',
	"LAST_NAME" VARCHAR2(50) DEFAULT ON NULL '-98',
	"PHONE" VARCHAR2(50),
	"EMAIL" VARCHAR2(50),
	"BIRTHDAY" DATE,
	"AGE" NUMBER(8,2),
	"OCCUPATION_ID" NUMBER(8,2),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
)
;

execute pkg_drop.DROP_proc('seq_responsible','sequence');
CREATE SEQUENCE seq_responsible
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE; 