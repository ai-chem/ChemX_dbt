{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with cur_synergy as (
    select * from {{ ref('cur_synergy') }}
),

np_dim as (
    select * from {{ ref('nanoparticle_list') }}
)

select
    cur_synergy.*,
    np_dim.nanoparticle_id
from cur_synergy
left join np_dim
    on cur_synergy.nanoparticle = np_dim.nanoparticle
    and cur_synergy.normalized_shape = np_dim.normalized_shape
    and cur_synergy.has_coating = np_dim.has_coating
    and cur_synergy.np_size_avg_nm = np_dim.np_size_avg_nm