-- CE_REGIONS
execute pkg_drop.DROP_proc('"BL_3NF"."CE_REGIONS"','table');
CREATE TABLE "BL_3NF"."CE_REGIONS"
(
	"REGION_ID" NUMBER(8,2) NOT NULL,
	"REGION_CODE" VARCHAR2(3),
	"REGION_NAME" VARCHAR2(50),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
)
;

execute pkg_drop.DROP_proc('seq_regions','sequence');
CREATE SEQUENCE seq_regions
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;