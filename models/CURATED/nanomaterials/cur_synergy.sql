{{ config(
    materialized='table',
    schema='curated'
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

)

select
    base.*,

    -- Булевый признак доступа
    {{ bool_from_int('access') }} as access_bool,

    -- Обработка текстовых чисел с запятой
    {{ parse_decimal_comma_to_float('np_size_min_nm') }} as np_size_min_nm_parsed,
    {{ parse_decimal_comma_to_float('zeta_potential_mv') }} as zeta_potential_mv_parsed

from base