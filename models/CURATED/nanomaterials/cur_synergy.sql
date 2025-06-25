{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with base as (

    -- Берём таблицу и удаляем записи с некорректными значениями
    select *
    from {{ ref('uni_synergy') }}
    where
        -- Оставляем только корректные числа или NULL в np_size_min_nm
        np_size_min_nm IS NULL
        OR regexp_replace(np_size_min_nm, ',', '.', 'g') ~ '^[-+]?\d+(\.\d+)?$'

        -- Оставляем только корректные числа или NULL в zeta_potential_mv
        AND (
            zeta_potential_mv IS NULL
            OR regexp_replace(zeta_potential_mv, ',', '.', 'g') ~ '^[-+]?\d+(\.\d+)?$'
        )

),

np_dim as (
    select * from {{ ref('nanoparticle_list') }}
),

joined as (
    select
        base.*,
        np_dim.nanoparticle_id
    from base
    left join np_dim
        on base.nanoparticle = np_dim.canonical_name
)

select
    joined.*,
    {{ bool_from_int('access') }} as access_bool,
    {{ parse_decimal_comma_to_float('np_size_min_nm') }} as np_size_min_nm_parsed,
    {{ parse_decimal_comma_to_float('zeta_potential_mv') }} as zeta_potential_mv_parsed
from joined