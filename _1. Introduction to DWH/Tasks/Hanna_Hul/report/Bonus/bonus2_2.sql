create synonym channels for sh.channels;
create synonym times for sh.times;
create synonym countries for sh.countries;
create synonym customers for sh.customers;
create synonym sales for sh.sales;

select DECODE(grouping_id(times.calendar_month_desc),1,'GRAND TOTAL',times.calendar_month_desc) year_month,
       -- grouping_id(times.calendar_month_desc) id_,
       DECODE(grouping_id(times.calendar_month_desc,channels.channel_desc,
       countries.country_name),3,'Total by Channels',channels.channel_desc) channel,
       DECODE(grouping_id(times.calendar_month_desc,channels.channel_desc,
       countries.country_name),1,concat(channels.channel_desc, ' Total by States'),countries.country_name) country,
       round(max (amount_sold)) max_sales$,
       round(min (amount_sold)) min_sales$,
       round(sum(amount_sold)) sales$
from sales, times, channels, customers, countries
where sales.time_id = times.time_id and
      sales.channel_id = channels.channel_id and
      sales.cust_id = customers.cust_id and
      customers.country_id = countries.country_id and
      times.calendar_month_desc = '2000-12' and
      channels.channel_desc IN ('Internet','Direct Sales')
group by rollup (times.calendar_month_desc,
       channels.channel_desc,
       countries.country_name);
      
      
       

