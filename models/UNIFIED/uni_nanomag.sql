-- models/UNIFIED/uni_nanomag.sql
{{ config(
    materialized='view'
) }}

SELECT
    -- Все исходные поля без изменений для большинства столбцов
    name,
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

    -- Преобразуем текстовые поля с числовыми значениями в числовой тип
    -- 1. fc_field_t
    CASE
        WHEN fc_field_t IS NULL OR TRIM(fc_field_t) = '' THEN NULL
        WHEN fc_field_t ~ '^-?[0-9]+(\.[0-9]+)?$' THEN CAST(fc_field_t AS FLOAT)
        ELSE NULL
    END AS fc_field_t_numeric,

    fc_field_t AS fc_field_t_original,

    -- 2. squid_temperature
    CASE
        WHEN squid_temperature IS NULL OR TRIM(squid_temperature) = '' THEN NULL
        WHEN squid_temperature ~ '^-?[0-9]+(\.[0-9]+)?$' THEN CAST(squid_temperature AS FLOAT)
        ELSE NULL
    END AS squid_temperature_numeric,

    squid_temperature AS squid_temperature_original,

    -- 3. squid_sat_mag
    CASE
        WHEN squid_sat_mag IS NULL OR TRIM(squid_sat_mag) = '' THEN NULL
        WHEN squid_sat_mag ~ '^-?[0-9]+(\.[0-9]+)?$' THEN CAST(squid_sat_mag AS FLOAT)
        ELSE NULL
    END AS squid_sat_mag_numeric,

    squid_sat_mag AS squid_sat_mag_original,

    -- 4. coercivity
    CASE
        WHEN coercivity IS NULL OR TRIM(coercivity) = '' THEN NULL
        WHEN coercivity ~ '^-?[0-9]+(\.[0-9]+)?$' THEN CAST(coercivity AS FLOAT)
        ELSE NULL
    END AS coercivity_numeric,

    coercivity AS coercivity_original,

    -- 5. squid_rem_mag
    CASE
        WHEN squid_rem_mag IS NULL OR TRIM(squid_rem_mag) = '' THEN NULL
        WHEN squid_rem_mag ~ '^-?[0-9]+(\.[0-9]+)?$' THEN CAST(squid_rem_mag AS FLOAT)
        ELSE NULL
    END AS squid_rem_mag_numeric,

    squid_rem_mag AS squid_rem_mag_original,

    -- 6. exchange_bias_shift_oe
    CASE
        WHEN exchange_bias_shift_oe IS NULL OR TRIM(exchange_bias_shift_oe) = '' THEN NULL
        WHEN exchange_bias_shift_oe ~ '^-?[0-9]+(\.[0-9]+)?$' THEN CAST(exchange_bias_shift_oe AS FLOAT)
        ELSE NULL
    END AS exchange_bias_shift_oe_numeric,

    exchange_bias_shift_oe AS exchange_bias_shift_oe_original,

    -- 7. vertical_loop_shift_m_vsl_emu_g
    CASE
        WHEN vertical_loop_shift_m_vsl_emu_g IS NULL OR TRIM(vertical_loop_shift_m_vsl_emu_g) = '' THEN NULL
        WHEN vertical_loop_shift_m_vsl_emu_g ~ '^-?[0-9]+(\.[0-9]+)?$' THEN CAST(vertical_loop_shift_m_vsl_emu_g AS FLOAT)
        ELSE NULL
    END AS vertical_loop_shift_m_vsl_emu_g_numeric,

    vertical_loop_shift_m_vsl_emu_g AS vertical_loop_shift_m_vsl_emu_g_original,

    hc_koe,
    doi,
    pdf,
    supp,
    journal,
    publisher,
    year,
    title,

    -- 8. access
    CAST(access AS INTEGER) AS access,

    -- Оставляем остальные столбцы без изменений
    verification_required,
    verified_by,
    verification_date,
    has_mistake_in_matadata,
    comment,
    article_name_folder,
    supp_info_name_folder,

    -- Добавляем метаданные
    current_timestamp AS dbt_loaded_at,
    'nanomag' AS source_table
FROM
    {{ source('raw', 'nanomag') }}