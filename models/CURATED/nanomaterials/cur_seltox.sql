{{ config(
    materialized='table',
    schema='curated'
) }}

with base as (

    select *
    from {{ ref('uni_seltox') }}
    where mic_np_µg_ml IS NULL
       OR mic_np_µg_ml ~ '^\d+(,\d+)?$'  -- допустимое число с запятой

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
    {{ parse_decimal_comma_to_float('mic_np_µg_ml') }} as mic_np_µg_ml_parsed,
    {{ normalize_shape("shape") }} as normalized_shape
from joined