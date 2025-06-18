-- models/UNIFIED/uni_nanozymes.sql
{{ config(
    materialized='view',
    schema='unified'
) }}

SELECT
    *,
    -- Добавляем метаданные
    current_timestamp AS dbt_loaded_at,
    'nanozymes' AS source_table
FROM
    {{ source('raw', 'nanozymes') }}