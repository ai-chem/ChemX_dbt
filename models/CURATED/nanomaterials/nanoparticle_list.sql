{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (nanoparticle_id)"
) }}

with all_nanoparticles as (

    -- Собираем все значения nanoparticle из нужных таблиц
    select nanoparticle from {{ ref('uni_cytotox') }}
    union
    select nanoparticle from {{ ref('uni_seltox') }}
    union
    select nanoparticle from {{ ref('uni_synergy') }}
    union
    select nanoparticle from {{ ref('uni_nanomag') }}
    union
    select nanoparticle from {{ ref('uni_nanozymes') }}

),

unique_nanoparticles as (

    select distinct nanoparticle
    from all_nanoparticles

)

select
    nanoparticle as canonical_name,
    row_number() over (order by nanoparticle) as nanoparticle_id
from unique_nanoparticles