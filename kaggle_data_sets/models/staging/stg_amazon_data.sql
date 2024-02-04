{{ config(
    materialized = 'external',
    local = 'output/amazon_stg',
    format = 'csv'
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['title','price','categories']) }} AS hashed_row,
    title,
    price,
    categories :: VARCHAR [] AS categories
FROM
    {{ ref("amazon_data_2023") }}
