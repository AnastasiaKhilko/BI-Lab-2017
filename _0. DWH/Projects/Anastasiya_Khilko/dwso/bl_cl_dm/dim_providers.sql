CREATE TABLE DIM_PROVIDERS
(
	"PROVIDER_SURR_ID" NUMBER(8) NOT NULL,
	"PROVIDER_CODE" NUMBER(4,2) NOT NULL,
	"PROVIDER_NAME" VARCHAR2(150) NOT NULL,
	"ADDRESS" VARCHAR(200) NOT NULL,
	"CITY_ID" NUMBER(8) NOT NULL,
	"EMAIL" VARCHAR2(150) NOT NULL,
	"PHONE" VARCHAR2(50) NOT NULL,
	"INSERT_DT" DATE NOT NULL,
	"UPDATE_DT" DATE NOT NULL
)
;