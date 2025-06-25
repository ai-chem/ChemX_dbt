{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with dedup_seltox as (

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
        dedup_seltox.*,
        np_dim.nanoparticle_id
    from dedup_seltox
    left join np_dim
        on dedup_seltox.nanoparticle = np_dim.canonical_name
)

select
    joined.*,
    {{ parse_decimal_comma_to_float('mic_np_µg_ml') }} as mic_np_µg_ml_parsed,
    {{ normalize_shape("shape") }} as normalized_shape
from joined