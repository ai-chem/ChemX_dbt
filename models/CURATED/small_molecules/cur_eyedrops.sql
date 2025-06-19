{{ config(
    materialized='view',
    schema='curated'
) }}

with base as (

    {{ deduplicate_model('uni_eyedrops') }}

)

select
    base.*,

    -- Обработка logp_original: приведение значения "-5,54" к числу -5.54
    {{ parse_decimal_comma_to_float('logp_original') }} as logp_cleaned

from base