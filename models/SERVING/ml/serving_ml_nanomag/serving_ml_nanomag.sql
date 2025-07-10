{{ config(materialized='table', schema='serving') }}

with fact as (
    select *
    from {{ ref('fact_nanomag_experiments') }}
),

np as (
    select
        nanoparticle_id,
        np_shell_2,
        xrd_scherrer_size,
        nanoparticle,
        np_shell,
        space_group_core,
        space_group_shell
    from {{ ref('dim_nanomag_nanoparticle') }}
)

select
    fact.id,
    np.np_shell_2,
    np.xrd_scherrer_size,
    fact.zfc_h_meas,
    fact.htherm_sar,
    fact.mri_r1,
    fact.mri_r2,
    np.nanoparticle,
    np.np_shell,
    np.space_group_core,
    np.space_group_shell,
    fact.squid_h_max,
    fact.hc_koe,
    fact.fc_field_t_numeric,
    fact.squid_temperature_numeric,
    fact.squid_sat_mag_numeric,
    fact.coercivity_numeric,
    fact.squid_rem_mag_numeric,
    fact.exchange_bias_shift_oe_numeric,
    fact.vertical_loop_shift_m_vsl_emu_g_numeric

from fact
left join np on fact.nanoparticle_id = np.nanoparticle_id