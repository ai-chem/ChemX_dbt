{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with dedup_cytotox as (

    {{ deduplicate_model('uni_cytotox') }}

),

-- Добавляем справочник наночастиц
np_dim as (
    select * from {{ ref('nanoparticle_list') }}
),

-- Соединяем основную таблицу с справочником по названию наночастицы
joined as (
    select
        dedup_cytotox.*,
        np_dim.nanoparticle_id
    from dedup_cytotox
    left join np_dim
        on dedup_cytotox.nanoparticle = np_dim.canonical_name
)

select
    joined.*,

    -- Булево: positive → true
    {{ bool_from_text_equals('surface_charge', 'Positive') }} as is_surface_positive,

    -- Булево: human (H) → true
    {{ bool_from_text_equals('human_animal', 'H') }} as is_human,

    -- Булево: access 1 → true
    {{ bool_from_int('access') }} as access_bool,

    -- Нормализуем форму наночастицы
    {{ normalize_shape("shape") }} as normalized_shape

from joined