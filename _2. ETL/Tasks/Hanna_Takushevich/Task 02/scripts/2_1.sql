SELECT
        CASE GROUPING_ID(
            g.country_name,
            t.service_class,
            t.flight_code,
            c.first_name
             || ' '
             || c.last_name,
            c.geo_desc
        )
            WHEN 31   THEN 'TOTAL'
            ELSE g.country_name
        END
    AS airline_country,
        CASE GROUPING_ID(
            g.country_name,
            t.service_class,
            t.flight_code,
            c.first_name
             || ' '
             || c.last_name,
            c.geo_desc
        )
            WHEN 15   THEN 'TOTAL'
            ELSE t.service_class
        END
    AS service_class,
    t.flight_code AS flight_code,
    c.first_name
     || ' '
     || c.last_name AS customer,
    c.geo_desc,
    SUM(price)
FROM
    tmp_sales s
    JOIN tmp_date d ON s.date_id = d.date_id
    JOIN tmp_ticket t ON t.ticket_id = s.ticket_id
    JOIN tmp_customers c ON c.cust_id = s.cust_id
    JOIN tmp_airline a ON a.airline_id = s.airline_id
    JOIN tmp_geo g ON g.geo_id = a.airline_geo_id
WHERE
    d.date_id = TO_DATE('02-02-2016','dd-mm-yyyy')
GROUP BY
    ROLLUP(
        g.country_name,t.service_class,
        (t.flight_code,c.first_name || ' ' || c.last_name,c.geo_desc)
    )
ORDER BY 1;