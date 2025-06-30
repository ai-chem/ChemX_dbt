{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with cur_cytotox as (
    select * from {{ ref('cur_cytotox') }}
),

np_list as (
    select * from {{ ref('nanoparticle_list') }}
)

select
    cur_cytotox.*,
    np_list.nanoparticle_id
from cur_cytotox
left join np_list
  on cur_cytotox.nanoparticle IS NOT DISTINCT FROM np_list.nanoparticle
  and cur_cytotox.normalized_shape IS NOT DISTINCT FROM np_list.normalized_shape
  and cur_cytotox.has_coating IS NOT DISTINCT FROM np_list.has_coating
  and cur_cytotox.np_size_avg_nm IS NOT DISTINCT FROM np_list.np_size_avg_nm