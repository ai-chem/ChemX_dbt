{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (id)"
) }}

with base as (

    {{ deduplicate_model('uni_nanomag') }}

)

select
    base.*,

    -- Булева интерпретация поля access
    {{ bool_from_int('access') }} as access_bool,
    {{ normalize_nanoparticle("nanoparticle") }} as normalized_nanoparticle

from base