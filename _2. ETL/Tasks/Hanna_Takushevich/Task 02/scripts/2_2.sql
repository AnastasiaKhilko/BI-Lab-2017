-- per day

SELECT
        CASE
            WHEN GROUPING_ID(s.date_id,service_class) = 3 THEN 'TOTAL'
            ELSE TO_CHAR(s.date_id,'dd-mm-yyyy')
        END
    sales_date,
        CASE
            WHEN GROUPING_ID(s.date_id,service_class) = 1  THEN 'TOTAL PER DAY'
            ELSE service_class
        END
    AS service_class,
    SUM(amount) AS saled_amount
FROM
    tmp_sales s
    JOIN tmp_date d ON s.date_id = d.date_id
    JOIN tmp_ticket t ON t.ticket_id = s.ticket_id
WHERE
        dateyear > 2016
    AND
        datemonth = 3
GROUP BY
    ROLLUP(s.date_id,service_class);



--per month

SELECT
        CASE
            WHEN GROUPING_ID(d.datemonthyearname,service_class) = 3 THEN 'TOTAL'
            ELSE TO_CHAR(d.datemonthyearname)
        END
    sales_date,
        CASE
            WHEN GROUPING_ID(d.datemonthyearname,service_class) = 1  THEN 'TOTAL PER MONTH'
            ELSE service_class
        END
    AS service_class,
    SUM(amount) AS saled_amount
FROM
    tmp_sales s
    JOIN tmp_date d ON s.date_id = d.date_id
    JOIN tmp_ticket t ON t.ticket_id = s.ticket_id
WHERE
        dateyear > 2016
    AND
        datemonth < 4
GROUP BY
    ROLLUP(d.datemonthyearname,service_class);



--per quarter

SELECT
        CASE
            WHEN GROUPING_ID(d.datequarteryear,service_class) = 3 THEN 'TOTAL'
            ELSE 'Q'
             || TO_CHAR(d.datequarteryear)
        END
    sales_date,
        CASE
            WHEN GROUPING_ID(d.datequarteryear,service_class) = 1  THEN 'TOTAL PER QUARTER'
            ELSE service_class
        END
    AS service_class,
    SUM(amount) AS saled_amount
FROM
    tmp_sales s
    JOIN tmp_date d ON s.date_id = d.date_id
    JOIN tmp_ticket t ON t.ticket_id = s.ticket_id
WHERE
    dateyear = 2016
GROUP BY
    ROLLUP(d.datequarteryear,service_class);


--per year

SELECT
        CASE
            WHEN GROUPING_ID(d.dateyear,service_class) = 3 THEN 'TOTAL'
            ELSE TO_CHAR(d.dateyear)
        END
    sales_date,
        CASE
            WHEN GROUPING_ID(d.dateyear,service_class) = 1  THEN 'TOTAL PER YEAR'
            ELSE service_class
        END
    AS service_class,
    SUM(amount) AS saled_amount
FROM
    tmp_sales s
    JOIN tmp_date d ON s.date_id = d.date_id
    JOIN tmp_ticket t ON t.ticket_id = s.ticket_id
WHERE
    dateyear > 2014
GROUP BY
    ROLLUP(d.dateyear,service_class);