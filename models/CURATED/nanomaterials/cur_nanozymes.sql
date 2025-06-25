-- models/curated/nanomaterials/cur_nanozymes.sql

{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (id)"
) }}

with base as (

    {{ deduplicate_model('uni_nanozymes') }}

)

select
    base.*,

    -- Преобразование access: 1 → true, 0 → false
    {{ bool_from_int('access') }} as access_bool,

    -- LENGTH (например, "10", "12–15")
    {{ parse_range_component('length', 'lower') }} as length_lower,
    {{ parse_range_component('length', 'upper') }} as length_upper,
    {{ parse_range_component('length', 'mean') }}  as length_mean,

    -- WIDTH
    {{ parse_range_component('width', 'lower') }} as width_lower,
    {{ parse_range_component('width', 'upper') }} as width_upper,
    {{ parse_range_component('width', 'mean') }}  as width_mean,

    -- DEPTH
    {{ parse_range_component('depth', 'lower') }} as depth_lower,
    {{ parse_range_component('depth', 'upper') }} as depth_upper,
    {{ parse_range_component('depth', 'mean') }}  as depth_mean

from base