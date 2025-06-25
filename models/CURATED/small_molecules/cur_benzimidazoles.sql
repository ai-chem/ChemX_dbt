{{ config(
    materialized='table',
    schema='curated'
) }}

with base as (

    {{ deduplicate_model('uni_benzimidazoles') }}

)

select
    base.*,
    {{ parse_numeric_with_error('target_value') }} AS target_value_parsed,
    {{ parse_error_component('target_value') }} AS target_value_error
from base