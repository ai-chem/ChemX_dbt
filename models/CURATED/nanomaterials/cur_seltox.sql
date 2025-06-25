{{ config(
    materialized='table',
    schema='curated'
) }}

with base as (

    select *
    from {{ ref('uni_seltox') }}
    where mic_np_µg_ml IS NULL
       OR mic_np_µg_ml ~ '^\d+(,\d+)?$'  -- допустимое число с запятой

)

select
    base.*,

    {{ parse_decimal_comma_to_float('mic_np_µg_ml') }} as mic_np_µg_ml_parsed,

    -- Нормализуем форму наночастицы
    {{ normalize_shape("shape") }} as normalized_shape

from base