drop table wrk_fact;

Create table wrk_fact (
order_code VARCHAR2 ( 200  ) not null,
cost number(8) DEFAULT ON NULL '-98',
minPrice number(8) DEFAULT ON NULL '-98',
maxPrice number(8) DEFAULT ON NULL '-98',
avgPrice VARCHAR2 ( 200  ) DEFAULT ON NULL '-98',
sdPrice VARCHAR2 ( 200  ) DEFAULT ON NULL '-98',
start_dt  date not null,
end_dt  date not null
);
