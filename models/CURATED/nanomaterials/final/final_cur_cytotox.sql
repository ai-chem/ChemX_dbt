{{ config(
    materialized='table',
    schema='curated',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (serial_number)"
) }}

with cur_cytotox as (
    select * from {{ ref('cur_cytotox') }}
),

np_dim as (
    select * from {{ ref('nanoparticle_list') }}
)

select
    cur_cytotox.*,
    np_dim.nanoparticle_id
from cur_cytotox
left join np_dim
    on cur_cytotox.nanoparticle = np_dim.nanoparticle
    and cur_cytotox.normalized_shape = np_dim.normalized_shape
    and cur_cytotox.has_coating = np_dim.has_coating
    and cur_cytotox.np_size_avg_nm = np_dim.np_size_avg_nm