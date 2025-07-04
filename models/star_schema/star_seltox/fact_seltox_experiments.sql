-- Факт-таблица экспериментов.
-- Каждая строка — отдельный эксперимент или измерение из seltox.
-- Ссылается на справочники наночастиц, бактерий, публикаций и источников через внешние ключи.
-- Содержит только специфичные для эксперимента поля (условия, результаты, параметры теста).

{{ config(
    materialized='table',
    schema='star_schema',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

-- Справочник публикаций: сопоставляем DOI с publication_id
with publication as (
    select
        doi,
        row_number() over (order by doi) as publication_id
    from (
        select distinct doi from {{ ref('final_cur_seltox') }}
    ) as unique_publications
),

-- Справочник бактерий: сопоставляем комбинацию bacteria, strain, mdr с bacteria_id
bacteria as (
    select
        bacteria,
        strain,
        mdr,
        row_number() over (order by bacteria, strain, mdr) as bacteria_id
    from (
        select distinct bacteria, strain, mdr from {{ ref('final_cur_seltox') }}
    ) as unique_bacteria
),

-- Справочник источников: сопоставляем комбинацию source_table, dbt_loaded_at с source_id
source as (
    select
        source_table,
        dbt_loaded_at,
        row_number() over (order by source_table, dbt_loaded_at) as source_id
    from (
        select distinct source_table, dbt_loaded_at from {{ ref('final_cur_seltox') }}
    ) as unique_sources
)

select
    -- Уникальный идентификатор эксперимента (первичный ключ)
    serial_number,

    -- Внешний ключ на справочник наночастиц (берём nanoparticle_id напрямую из данных)
    nanoparticle_id,

    -- Внешний ключ на справочник бактерий
    bacteria.bacteria_id,

    -- Внешний ключ на справочник публикаций
    publication.publication_id,

    -- Внешний ключ на справочник источников данных
    source.source_id,

    -- Специфичные для эксперимента поля (условия, результаты, параметры теста)
    method,                  -- Тип теста (например, MIC, ZOI)
    mic_np_µg_ml,            -- Минимальная подавляющая концентрация (MIC) наночастицы, мкг/мл
    mic_np_µg_ml_parsed,     -- Стандартизированное значение MIC
    concentration,           -- Концентрация наночастицы для ZOI, мкг/мл
    zoi_np_mm,               -- Зона ингибирования (ZOI) для наночастицы, мм
    time_set_hours           -- Длительность эксперимента, часы

from {{ ref('final_cur_seltox') }} as final_cur_seltox

-- Присоединяем справочник публикаций по DOI
left join publication
    on final_cur_seltox.doi = publication.doi

-- Присоединяем справочник бактерий по bacteria, strain, mdr
left join bacteria
    on final_cur_seltox.bacteria IS NOT DISTINCT FROM bacteria.bacteria
    and final_cur_seltox.strain IS NOT DISTINCT FROM bacteria.strain
    and final_cur_seltox.mdr IS NOT DISTINCT FROM bacteria.mdr

-- Присоединяем справочник источников по source_table и dbt_loaded_at
left join source
    on final_cur_seltox.source_table = source.source_table
    and final_cur_seltox.dbt_loaded_at = source.dbt_loaded_at