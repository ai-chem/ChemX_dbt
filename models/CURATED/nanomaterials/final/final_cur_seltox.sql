{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with cur_seltox as (
    select * from {{ ref('cur_seltox') }}
),

np_dim as (
    select * from {{ ref('nanoparticle_list') }}
)

select
    cur_seltox.*,
    np_dim.nanoparticle_id
from cur_seltox
left join np_dim
    on cur_seltox.nanoparticle = np_dim.nanoparticle
    and cur_seltox.normalized_shape = np_dim.normalized_shape
    and cur_seltox.has_coating = np_dim.has_coating
    and cur_seltox.np_size_avg_nm = np_dim.np_size_avg_nm