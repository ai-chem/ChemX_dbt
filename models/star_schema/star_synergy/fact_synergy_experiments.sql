-- Факт-таблица экспериментов (fact_synergy_experiments).
-- Каждая строка — отдельный эксперимент или измерение.
-- Ссылается на справочники наночастиц, бактерий, лекарств, публикаций и источников через внешние ключи.
-- Содержит только специфичные для эксперимента поля.

{{ config(
    materialized='table',
    schema='star_schema',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with publication as (
    select
        doi,
        row_number() over (order by doi) as publication_id
    from (
        select distinct doi from {{ ref('final_cur_synergy') }}
    ) as unique_publications
),
bacteria as (
    select
        bacteria,
        strain,
        mdr,
        row_number() over (order by bacteria, strain, mdr) as bacteria_id
    from (
        select distinct bacteria, strain, mdr from {{ ref('final_cur_synergy') }}
    ) as unique_bacteria
),
drug as (
    select
        drug,
        row_number() over (order by drug) as drug_id
    from (
        select distinct drug from {{ ref('final_cur_synergy') }}
        where drug is not null and drug <> ''
    ) as unique_drugs
),
source as (
    select
        source_table,
        dbt_loaded_at,
        row_number() over (order by source_table, dbt_loaded_at) as source_id
    from (
        select distinct source_table, dbt_loaded_at from {{ ref('final_cur_synergy') }}
    ) as unique_sources
)

select
    serial_number,
    nanoparticle_id,
    bacteria.bacteria_id,
    drug.drug_id,
    publication.publication_id,
    source.source_id,

    -- Специфичные для эксперимента поля
    method,
    zoi_drug_mm_or_mic__µg_ml,
    error_zoi_drug_mm_or_mic_µg_ml,
    zoi_np_mm_or_mic_np_µg_ml,
    error_zoi_np_mm_or_mic_np_µg_ml,
    zoi_drug_np_mm_or_mic_drug_np_µg_ml,
    error_zoi_drug_np_mm_or_mic_drug_np_µg_ml,
    fold_increase_in_antibacterial_activity,
    fic,
    effect,
    drug_dose_µg_disk,
    np_concentration_µg_ml,
    combined_mic,
    peptide_mic,
    "viability_%",
    viability_error,
    time_hr

from {{ ref('final_cur_synergy') }} as final_cur_synergy

left join publication
    on final_cur_synergy.doi = publication.doi

left join bacteria
    on final_cur_synergy.bacteria IS NOT DISTINCT FROM bacteria.bacteria
    and final_cur_synergy.strain IS NOT DISTINCT FROM bacteria.strain
    and final_cur_synergy.mdr IS NOT DISTINCT FROM bacteria.mdr

left join drug
    on final_cur_synergy.drug IS NOT DISTINCT FROM drug.drug

left join source
    on final_cur_synergy.source_table = source.source_table
    and final_cur_synergy.dbt_loaded_at = source.dbt_loaded_at