{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with dedup_cytotox as (
    {{ deduplicate_model('uni_cytotox') }}
)

select
    dedup_cytotox.*,

    -- Булево: positive - true
    {{ bool_from_text_equals('surface_charge', 'Positive') }} as is_surface_positive,

    -- Булево: human (H) - true
    {{ bool_from_text_equals('human_animal', 'H') }} as is_human,

    -- Булево: access 1 - true
    {{ bool_from_int('access') }} as access_bool,

    -- Нормализуем форму наночастицы (упрощение)
    {{ normalize_shape("shape") }} as normalized_shape,

    -- Стандартизируем метод синтеза по группам (упрощение)
    {{ standardize_synthesis_method('synthesis_method') }} as standardized_synthesis_method,

    size_in_medium_nm as np_size_avg_nm,

    {{ create_has_coating_column('coat_functional_group') }}

from dedup_cytotox