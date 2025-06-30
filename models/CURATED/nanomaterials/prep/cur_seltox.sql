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

)

select
    dedup_seltox.*,
    {{ parse_decimal_comma_to_float('mic_np_µg_ml') }} as mic_np_µg_ml_parsed,

    {{ normalize_shape("shape") }} as normalized_shape,
    {{ standardize_synthesis_method('synthesis_method') }} as standardized_synthesis_method,
    {{ create_has_coating_column('coating', 'bigint') }}
from dedup_seltox