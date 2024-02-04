{{ config(
    materialized = 'external',
    local = 'kaggle_data_sets/output/hola',
    format = 'csv'
) }}

SELECT
    category,
    ARRAY_AGG(title) AS products_in_category,
    COUNT(
        DISTINCT title
    ) AS cnt_distinct_products,
    COUNT(*) AS cnt_purchased,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price
FROM
    {{ ref("stg_amazon_data") }} AS t,
    LATERAL unnest(
        t.categories :: VARCHAR []
    ) AS category(category)
GROUP BY
    ALL
