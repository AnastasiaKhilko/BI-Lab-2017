SELECT
    CASE
        WHEN GROUPING_ID (department_code, product_name) = 2
            THEN 'Total by Stores'
        WHEN GROUPING_ID (department_code, product_name) = 3
            THEN 'GRAND TOTAL'
        ELSE department_code
    END AS department_code,
    CASE
        WHEN GROUPING_ID (department_code, product_name) = 1
            THEN 'Total by Products'
        WHEN GROUPING_ID (department_code, product_name) = 3
            THEN ''
        ELSE product_name
    END AS product_name,
    sum(amount),
    sum(quantity)
FROM FACT_SALES
INNER JOIN dim_products USING (product_id)
INNER JOIN dim_departments USING (department_id)
GROUP BY CUBE(department_code, product_name);