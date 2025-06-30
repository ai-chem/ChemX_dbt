{{ config(
    materialized='table',
    schema='star_schema'
) }}

-- dim_source.sql
select
    row_number() over (
        order by source_table, dbt_loaded_at, dbt_curated_at
    ) as source_id,
    source_table,
    dbt_loaded_at,
    dbt_curated_at
from (
    select distinct
        source_table,
        dbt_loaded_at,
        dbt_curated_at
    from {{ ref('final_cur_cytotox') }}
) metadata