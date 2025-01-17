-- dim_PROMOTIONS
execute bl_cl.PKG_DROP.DROP_Proc('"DWH"."DIM_PROMOTIONS"','table');
CREATE TABLE "DWH"."DIM_PROMOTIONS"
(
  "PROMO_SURR_ID" NUMBER(8),
	"PROMO_ID" NUMBER(8),
	"PROMO_NAME" VARCHAR2(100),
	"PROMO_DESC" VARCHAR2(100),
	"PROMO_COST" NUMBER(8,2),
	"START_DT" DATE,
	"END_DT" DATE,
	"IS_ACTIVE" VARCHAR(1),
  "UPDATE_DT" DATE,
	"INSERT_DT" DATE
)
;

execute bl_cl.pkg_drop.DROP_proc('seq_dpromotion','sequence');
CREATE SEQUENCE seq_dpromotion
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE; 