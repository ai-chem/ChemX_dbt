-- Факт-таблица экспериментов (fact_experiments).
-- Каждая строка — отдельный эксперимент или измерение.
-- Ссылается на справочники наночастиц, публикаций, клеточных линий и источников через внешние ключи.
-- Содержит только специфичные для эксперимента поля (например, условия, результаты, параметры теста).

{{ config(
    materialized='table',
    schema='star_schema',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with pub as (
    select
        doi,
        row_number() over (order by doi) as publication_id
    from (
        select distinct doi from {{ ref('final_cur_cytotox') }}
    ) t
)

select
    serial_number,
    nanoparticle_id,
    pub.publication_id,
    cell_line_id,
    source.source_id,  -- добавляем ссылку на справочник источников

    -- Оставляем только специфичные для эксперимента поля
    no_of_cells_cells_well,
    time_hr,
    concentration,
    test,
    test_indicator,
    "viability_%"

from {{ ref('final_cur_cytotox') }} final_cur_cytotox
left join pub
    on final_cur_cytotox.doi = pub.doi
left join {{ ref('dim_cell_line') }} dim_cell_line
    on {{ generate_cell_line_name('final_cur_cytotox') }} = dim_cell_line.canonical_cell_line_name
left join {{ ref('dim_source') }} source
    on final_cur_cytotox.source_table = source.source_table
    and final_cur_cytotox.dbt_loaded_at = source.dbt_loaded_at
    and final_cur_cytotox.dbt_curated_at = source.dbt_curated_at