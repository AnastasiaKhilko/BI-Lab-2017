-- CLS_LOCALIZATION [lookup]
execute pkg_drop.DROP_proc('CLS_LOCALIZATION','table');           
CREATE TABLE "CLS_LOCALIZATION"
(
	"LOCALIZATION_ID" NUMBER(8) NOT NULL,
	"LOCALIZATION_NAME" VARCHAR2(50)
)
;

execute pkg_drop.DROP_proc('seq_localization','sequence');
CREATE SEQUENCE seq_localization
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;