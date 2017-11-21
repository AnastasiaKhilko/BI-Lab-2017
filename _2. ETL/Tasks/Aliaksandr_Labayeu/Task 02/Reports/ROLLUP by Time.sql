SELECT 
    (CASE
        WHEN grouping_id (year, quarter, month_year, date_id) = 15
        THEN 'GRAND TOTAL'
        ELSE to_char(year)
        END
        ) AS year_sales,
    (CASE
        WHEN grouping_id (year, quarter, month_year, date_id) = 7
        THEN 'YEAR TOTAL'
        ELSE to_char(year)
        END
        ) AS half_year_sales,
    (CASE
        WHEN grouping_id (year, quarter, month_year, date_id) = 3
        THEN 'QUARTER TOTAL'
        ELSE to_char(year)
        END
        ) AS quarter_sales,
    (CASE
        WHEN grouping_id (year, quarter, month_year, date_id) = 1
        THEN 'MONTH TOTAL'
        ELSE to_char(year)
        END
        ) AS month_sales,
    SUM(amount),
    SUM(quantity)
FROM FACT_SALES 
INNER JOIN dim_date USING (date_id)
GROUP BY ROLLUP (year, quarter, month_year, date_id);