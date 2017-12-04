/**===============================================*\
Name...............:   Normalized table dim_dates DM layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   30-Nov-2017
\*=============================================== */

truncate table dim_dates;
/
--**********************************************
insert into dim_dates
select 
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
/
commit;
/