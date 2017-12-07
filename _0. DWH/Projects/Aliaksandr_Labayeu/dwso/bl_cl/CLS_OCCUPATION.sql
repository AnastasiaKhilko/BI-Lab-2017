-- CLS_OCCUPATION
execute pkg_drop.DROP_proc('CLS_OCCUPATION','table');           
CREATE TABLE CLS_OCCUPATION
(
	"OCCUPATION_CODE" VARCHAR2(20),
	"OCCUPATION_NAME" VARCHAR2(100),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT TRUNC(SYSDATE)
)
;

execute pkg_drop.DROP_proc('seq_occupation','sequence');
CREATE SEQUENCE seq_occupation
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE; 