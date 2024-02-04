select 
{{dbt_utils.generate_surrogate_key(['title','price'])}}as row_id,
*
 from {{ref('amazon_data_2023')}}