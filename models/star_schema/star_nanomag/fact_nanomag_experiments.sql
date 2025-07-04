-- Факт-таблица экспериментов (fact_nanomag_experiments).
-- Каждая строка — отдельное измерение или эксперимент.
-- Ссылается на справочники наночастиц, публикаций, источников и валидации через внешние ключи.
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
        select distinct doi from {{ ref('final_cur_nanomag') }}
    ) as unique_publications
),
nanoparticle as (
    select
        nanoparticle,
        np_shell,
        np_shell_2,
        space_group_core,
        space_group_shell,
        xrd_scherrer_size,
        row_number() over (
            order by nanoparticle, np_shell, np_shell_2, space_group_core, space_group_shell, xrd_scherrer_size
        ) as nanoparticle_id
    from (
        select distinct nanoparticle, np_shell, np_shell_2, space_group_core, space_group_shell, xrd_scherrer_size
        from {{ ref('final_cur_nanomag') }}
    ) as unique_nanoparticles
),
source as (
    select
        source_table,
        dbt_loaded_at,
        dbt_curated_at,
        row_number() over (order by source_table, dbt_loaded_at, dbt_curated_at) as source_id
    from (
        select distinct source_table, dbt_loaded_at, dbt_curated_at from {{ ref('final_cur_nanomag') }}
    ) as unique_sources
),
validation as (
    select
        verified_by,
        verification_date,
        has_mistake_in_matadata,
        verification_required,
        comment,
        row_number() over (
            order by verified_by, verification_date, has_mistake_in_matadata, verification_required, comment
        ) as validation_id
    from (
        select distinct verified_by, verification_date, has_mistake_in_matadata, verification_required, comment
        from {{ ref('final_cur_nanomag') }}
    ) as unique_validation
)

select
    -- Уникальный идентификатор строки (первичный ключ)
    final_cur_nanomag.id,

    -- Внешние ключи на справочники
    nanoparticle.nanoparticle_id,
    publication.publication_id,
    source.source_id,
    validation.validation_id,

    -- Экспериментальные параметры (указываем явно алиас)
    final_cur_nanomag.zfc_h_meas,
    final_cur_nanomag.mri_r1,
    final_cur_nanomag.mri_r2,
    final_cur_nanomag.htherm_sar,
    final_cur_nanomag.hc_koe,
    final_cur_nanomag.vertical_loop_shift_m_vsl_emu_g_numeric,
    final_cur_nanomag.squid_h_max,
    final_cur_nanomag.fc_field_t_numeric,
    final_cur_nanomag.squid_temperature_numeric,
    final_cur_nanomag.squid_sat_mag_numeric,
    final_cur_nanomag.coercivity_numeric,
    final_cur_nanomag.squid_rem_mag_numeric,
    final_cur_nanomag.exchange_bias_shift_oe_numeric

from {{ ref('final_cur_nanomag') }} as final_cur_nanomag

-- Присоединяем справочник наночастиц по ключевым полям
left join nanoparticle
    on final_cur_nanomag.nanoparticle IS NOT DISTINCT FROM nanoparticle.nanoparticle
    and final_cur_nanomag.np_shell IS NOT DISTINCT FROM nanoparticle.np_shell
    and final_cur_nanomag.np_shell_2 IS NOT DISTINCT FROM nanoparticle.np_shell_2
    and final_cur_nanomag.space_group_core IS NOT DISTINCT FROM nanoparticle.space_group_core
    and final_cur_nanomag.space_group_shell IS NOT DISTINCT FROM nanoparticle.space_group_shell
    and final_cur_nanomag.xrd_scherrer_size IS NOT DISTINCT FROM nanoparticle.xrd_scherrer_size

-- Присоединяем справочник публикаций по DOI
left join publication
    on final_cur_nanomag.doi = publication.doi

-- Присоединяем справочник источников по source_table, dbt_loaded_at, dbt_curated_at
left join source
    on final_cur_nanomag.source_table = source.source_table
    and final_cur_nanomag.dbt_loaded_at = source.dbt_loaded_at
    and final_cur_nanomag.dbt_curated_at = source.dbt_curated_at

-- Присоединяем справочник валидации по всем полям
left join validation
    on final_cur_nanomag.verified_by IS NOT DISTINCT FROM validation.verified_by
    and final_cur_nanomag.verification_date IS NOT DISTINCT FROM validation.verification_date
    and final_cur_nanomag.has_mistake_in_matadata IS NOT DISTINCT FROM validation.has_mistake_in_matadata
    and final_cur_nanomag.verification_required IS NOT DISTINCT FROM validation.verification_required
    and final_cur_nanomag.comment IS NOT DISTINCT FROM validation.comment