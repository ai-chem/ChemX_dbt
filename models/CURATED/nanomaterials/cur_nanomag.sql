{{ config(
    materialized='view',
    schema='curated'
) }}

with base as (

    {{ deduplicate_model('uni_nanomag') }}

)

select
    base.*,

    -- Булева интерпретация поля access
    {{ bool_from_int('access') }} as access_bool

from base