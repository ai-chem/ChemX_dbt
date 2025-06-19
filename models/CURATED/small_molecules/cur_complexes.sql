{{ config(
    materialized='view',
    schema='curated'
) }}

with base as (

    {{ deduplicate_model('uni_complexes') }}

)

select
    base.*,

    -- Перевод supplementary в boolean
    case
      when supplementary = 1 then true
      when supplementary = 0 then false
      else null
    end as supplementary_bool,

    -- Очистка target_original от запятых
    {{ parse_decimal_comma_to_float('target_original') }} as target_cleaned

from base