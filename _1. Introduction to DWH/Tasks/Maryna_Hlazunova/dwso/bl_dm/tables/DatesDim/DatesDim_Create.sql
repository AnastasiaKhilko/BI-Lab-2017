-- удаление таблицы DatesDim и создание ее с нуля

--drop table datesdim;

create table datesdim
(
	"DATE_ID" number(8) not null,
	"FULL_DATE" date,
	"DAY_WEEK" number(1),
	"DAY_WEEK_NAME" varchar2(50),
	"DAY_MONTH" number(2),
	"DAY_YEAR" number(3),
	"MONTH_NUM" number(2),
	"MONTH_NAME" varchar2(50),
	"QUARTER" number(1),
	"HALF_YEAR" number(1),
	"YEAR" number(4)
)
;

alter table datesdim 
 add constraint "PK_DATESDIM"
	primary key ("DATE_ID") using index
;