DROP TABLE cl_fact;
CREATE TABLE cl_fact
  (
	 order_code VARCHAR2 ( 200  ) not null,
      cost number(8) not null,
      minPrice number(8) not null,
      maxPrice number(8) not null,
      avgPrice number(8) not null,
      sdPrice number(8) not null,
      start_dt date not null,
      end_dt date not null
  );
GRANT SELECT ON cl_fact TO bl_3nf;