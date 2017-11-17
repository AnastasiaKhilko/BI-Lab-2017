-- чистим таблицу DatesDim и заполняем данными
truncate table datesdim;

insert into datesdim
select 10000+level as date_id,
to_date('31/12/2009','dd.mm.yyyy') + numtodsinterval(level,'day') as full_date,
to_number(to_char(to_date('31.12.09','dd.mm.yyyy') + numtodsinterval(level,'day'), 'd'))   as day_week,
to_char(to_date('31.12.09','dd.mm.yyyy')+ numtodsinterval(level,'day'),'day', 'nls_date_language=russian')   as day_week_name,
to_number(to_char(to_date('31/12/2009','dd.mm.yyyy') + numtodsinterval(level,'day'), 'dd'))  as day_month,
to_number(to_char(to_date('31/12/2009','dd.mm.yyyy') + numtodsinterval(level,'day'),'ddd'))  as day_year,
to_number(to_char(to_date('31/12/2009','dd.mm.yyyy') + numtodsinterval(level,'day'),'mm'))   as month_num,
to_char(to_date('31/12/2013','dd.mm.yyyy') + numtodsinterval(level,'day'), 'month', 'nls_date_language=russian')  as month_name,
to_number(to_char(to_date('31/12/2009','dd.mm.yyyy') + numtodsinterval(level,'day'), 'Q'))   as quarter,
case
    when to_char(to_date('31/12/2009','dd.mm.yyyy') + numtodsinterval(level,'day'),'MM')<'07'
    then 1
    else 2
  end as half_year,
to_number(to_char(to_date('31/12/2009','dd.mm.yyyy') + numtodsinterval(level,'day'),'YYYY')) as year
from dual connect by level < 10000
;

commit;
