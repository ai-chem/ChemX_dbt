-- models/UNIFIED/uni_synergy.sql
{{ config(
    materialized='view'
) }}

SELECT
    *,
    -- Добавляем метаданные
    current_timestamp AS dbt_loaded_at,
    'synergy' AS source_table
FROM
    {{ source('raw', 'synergy') }}