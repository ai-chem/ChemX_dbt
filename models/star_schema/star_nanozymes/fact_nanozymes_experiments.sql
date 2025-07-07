-- Факт-таблица экспериментов (fact_nanozymes_experiments).
-- Каждая строка — отдельный каталитический эксперимент с одной наночастицей.
-- Ссылается на справочники наночастиц, публикаций и источников через внешние ключи.
-- Содержит только специфичные для эксперимента поля.

{{ config(
    materialized='table',
    schema='star_schema',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (id)"
) }}

with publication as (
    select
        doi,
        row_number() over (order by doi) as publication_id
    from (
        select distinct doi from {{ ref('final_cur_nanozymes') }}
    ) as unique_publications
),
nanoparticle as (
    select
        nanoparticle,
        syngony,
        surface,
        length_lower,
        length_upper,
        length_mean,
        width_lower,
        width_upper,
        width_mean,
        depth_lower,
        depth_upper,
        depth_mean,
        row_number() over (
            order by nanoparticle, syngony, surface,
                     length_lower, length_upper, length_mean,
                     width_lower, width_upper, width_mean,
                     depth_lower, depth_upper, depth_mean
        ) as nanoparticle_id
    from (
        select distinct
            nanoparticle,
            syngony,
            surface,
            length_lower,
            length_upper,
            length_mean,
            width_lower,
            width_upper,
            width_mean,
            depth_lower,
            depth_upper,
            depth_mean
        from {{ ref('final_cur_nanozymes') }}
    ) as unique_nanoparticles
),
source as (
    select
        source_table,
        dbt_loaded_at,
        dbt_curated_at,
        row_number() over (order by source_table, dbt_loaded_at, dbt_curated_at) as source_id
    from (
        select distinct source_table, dbt_loaded_at, dbt_curated_at from {{ ref('final_cur_nanozymes') }}
    ) as unique_sources
)

select
    -- Уникальный идентификатор строки (первичный ключ)
    final_cur_nanozymes.id,

    -- Внешние ключи на справочники
    nanoparticle.nanoparticle_id,
    publication.publication_id,
    source.source_id,

    -- Экспериментальные параметры (только переменные, не входящие в справочники)
    final_cur_nanozymes.activity,
    final_cur_nanozymes.reaction_type,
    final_cur_nanozymes.target_source,
    final_cur_nanozymes.c_min,
    final_cur_nanozymes.c_max,
    final_cur_nanozymes.c_const,
    final_cur_nanozymes.c_const_unit,
    final_cur_nanozymes.ccat_value,
    final_cur_nanozymes.ccat_unit,
    final_cur_nanozymes.km_value,
    final_cur_nanozymes.km_unit,
    final_cur_nanozymes.vmax_value,
    final_cur_nanozymes.vmax_unit,
    final_cur_nanozymes.ph,
    final_cur_nanozymes.temperature

from {{ ref('final_cur_nanozymes') }} as final_cur_nanozymes

-- Присоединяем справочник наночастиц по ключевым полям
left join nanoparticle
    on final_cur_nanozymes.nanoparticle IS NOT DISTINCT FROM nanoparticle.nanoparticle
    and final_cur_nanozymes.syngony IS NOT DISTINCT FROM nanoparticle.syngony
    and final_cur_nanozymes.surface IS NOT DISTINCT FROM nanoparticle.surface
    and final_cur_nanozymes.length_lower IS NOT DISTINCT FROM nanoparticle.length_lower
    and final_cur_nanozymes.length_upper IS NOT DISTINCT FROM nanoparticle.length_upper
    and final_cur_nanozymes.length_mean IS NOT DISTINCT FROM nanoparticle.length_mean
    and final_cur_nanozymes.width_lower IS NOT DISTINCT FROM nanoparticle.width_lower
    and final_cur_nanozymes.width_upper IS NOT DISTINCT FROM nanoparticle.width_upper
    and final_cur_nanozymes.width_mean IS NOT DISTINCT FROM nanoparticle.width_mean
    and final_cur_nanozymes.depth_lower IS NOT DISTINCT FROM nanoparticle.depth_lower
    and final_cur_nanozymes.depth_upper IS NOT DISTINCT FROM nanoparticle.depth_upper
    and final_cur_nanozymes.depth_mean IS NOT DISTINCT FROM nanoparticle.depth_mean

-- Присоединяем справочник публикаций по DOI
left join publication
    on final_cur_nanozymes.doi = publication.doi

-- Присоединяем справочник источников по source_table, dbt_loaded_at, dbt_curated_at
left join source
    on final_cur_nanozymes.source_table = source.source_table
    and final_cur_nanozymes.dbt_loaded_at = source.dbt_loaded_at
    and final_cur_nanozymes.dbt_curated_at = source.dbt_curated_at