{{ config(materialized='table', schema='serving') }}

with fact as (
    select *
    from {{ ref('fact_nanozymes_experiments') }}
),

np as (
    select
        nanoparticle_id,
        nanoparticle,
        syngony,
        length,
        width,
        depth,
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
    from {{ ref('dim_nanozymes_nanoparticle') }}
)

select
    fact.id,
    np.nanoparticle,
    np.syngony,
    np.length,
    np.width,
    np.depth,
    np.surface,
    np.length_lower,
    np.length_upper,
    np.length_mean,
    np.width_lower,
    np.width_upper,
    np.width_mean,
    np.depth_lower,
    np.depth_upper,
    np.depth_mean,

    fact.activity,
    fact.reaction_type,
    fact.target_source,
    fact.c_min,
    fact.c_max,
    fact.c_const,
    fact.c_const_unit,
    fact.ccat_value,
    fact.ccat_unit,
    fact.km_value,
    fact.km_unit,
    fact.vmax_value,
    fact.vmax_unit,
    fact.ph,
    fact.temperature

from fact
left join np on fact.nanoparticle_id = np.nanoparticle_id