{{ config(
    materialized='table',
    schema='curated',
    unique_key='sn'
) }}

with base as (

    {{ deduplicate_model('uni_cytotox') }}

),

-- Добавляем справочник наночастиц
np_dim as (
    select * from {{ ref('nanoparticle_list') }}
),

-- Соединяем основную таблицу с справочником по названию наночастицы
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

    -- Булево: positive → true
    {{ bool_from_text_equals('surface_charge', 'Positive') }} as is_surface_positive,

    -- Булево: human (H) → true
    {{ bool_from_text_equals('human_animal', 'H') }} as is_human,

    -- Булево: access 1 → true
    {{ bool_from_int('access') }} as access_bool,

    -- Нормализуем форму наночастицы
    {{ normalize_shape("shape") }} as normalized_shape

from joined