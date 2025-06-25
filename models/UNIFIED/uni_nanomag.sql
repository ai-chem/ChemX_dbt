{{ config(
    materialized='view',
    schema='unified'
) }}

SELECT
    -- Поля без изменений
    name AS nanoparticle,
    np_shell_2,
    np_hydro_size,
    xrd_scherrer_size,
    zfc_h_meas,
    htherm_sar,
    mri_r1,
    mri_r2,
    emic_size,
    instrument,
    core_shell_formula,
    np_core,
    np_shell,
    space_group_core,
    space_group_shell,
    squid_h_max,
    hc_koe,
    journal,
    publisher,
    year,
    title,
    pdf,
    doi,
    supp,
    article_name_folder,
    supp_info_name_folder,
    comment,
    has_mistake_in_matadata,
    verification_required,
    verified_by,
    verification_date,

    -- Обработка проблемных текстовых полей (запятая → точка)

    -- fc_field_t
    {{ parse_decimal_comma_to_float('fc_field_t') }} as fc_field_t_numeric,
    fc_field_t as fc_field_t_original,

    -- squid_temperature
    {{ parse_decimal_comma_to_float('squid_temperature') }} as squid_temperature_numeric,
    squid_temperature as squid_temperature_original,

    -- squid_sat_mag
    {{ parse_decimal_comma_to_float('squid_sat_mag') }} as squid_sat_mag_numeric,
    squid_sat_mag as squid_sat_mag_original,

    -- coercivity
    {{ parse_decimal_comma_to_float('coercivity') }} as coercivity_numeric,
    coercivity as coercivity_original,

    -- squid_rem_mag
    {{ parse_decimal_comma_to_float('squid_rem_mag') }} as squid_rem_mag_numeric,
    squid_rem_mag as squid_rem_mag_original,

    -- exchange_bias_shift_oe
    {{ parse_decimal_comma_to_float('exchange_bias_shift_oe') }} as exchange_bias_shift_oe_numeric,
    exchange_bias_shift_oe as exchange_bias_shift_oe_original,

    -- vertical_loop_shift_m_vsl_emu_g
    {{ parse_decimal_comma_to_float('vertical_loop_shift_m_vsl_emu_g') }} as vertical_loop_shift_m_vsl_emu_g_numeric,
    vertical_loop_shift_m_vsl_emu_g as vertical_loop_shift_m_vsl_emu_g_original,

    -- access: int
    CAST(access AS INTEGER) AS access,

    -- Метаданные
    current_timestamp AS dbt_loaded_at,
    'nanomag' AS source_table

FROM
    {{ source('raw', 'nanomag') }}