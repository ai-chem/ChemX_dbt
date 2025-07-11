{{ config(materialized='table', schema='serving') }}

with fact as (
    select *
    from {{ ref('fact_seltox_experiments') }}
),

np as (
    select
        nanoparticle_id,
        nanoparticle,
        shape,
        coating,
        has_coating,
        np_size_min_nm,
        np_size_max_nm,
        np_size_avg_nm,
        zeta_potential_mv,
        hydrodynamic_diameter_nm,
        normalized_shape,
        standardized_synthesis_method,
        synthesis_method,
        solvent_for_extract,
        temperature_for_extract_c,
        duration_preparing_extract_min,
        precursor_of_np,
        concentration_of_precursor_mm
    from {{ ref('dim_seltox_nanoparticle') }}
),

bact as (
    select
        bacteria_id,
        bacteria,
        mdr,
        strain
    from {{ ref('dim_seltox_bacteria') }}
)

select
    fact.serial_number,
    np.nanoparticle,
    np.shape,
    np.coating,
    np.has_coating,
    np.np_size_min_nm,
    np.np_size_max_nm,
    np.np_size_avg_nm,
    np.zeta_potential_mv,
    np.hydrodynamic_diameter_nm,
    np.normalized_shape,
    np.standardized_synthesis_method,
    np.synthesis_method,
    np.solvent_for_extract,
    np.temperature_for_extract_c,
    np.duration_preparing_extract_min,
    np.precursor_of_np,
    np.concentration_of_precursor_mm,

    fact.method,
    fact.mic_np_µg_ml,
    fact.mic_np_µg_ml_parsed,
    fact.concentration,
    fact.zoi_np_mm,
    fact.time_set_hours,

    bact.bacteria,
    bact.mdr,
    bact.strain

from fact
left join np on fact.nanoparticle_id = np.nanoparticle_id
left join bact on fact.bacteria_id = bact.bacteria_id