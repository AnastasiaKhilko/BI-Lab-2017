-- CE_CONSUMER_RATE
execute pkg_drop.DROP_proc('"BL_3NF"."CE_CONSUMER_RATE"','table');
CREATE TABLE "BL_3NF"."CE_CONSUMER_RATE"
(
	"CONSUMER_RATE_ID" NUMBER(8,2) NOT NULL,
	"RATE_TITLE" VARCHAR2(50)
)
;