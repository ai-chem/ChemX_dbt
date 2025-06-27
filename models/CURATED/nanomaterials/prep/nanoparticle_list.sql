with unique_nanoparticles as (
    select distinct
        nanoparticle,
        normalized_shape,
        has_coating,
        np_size_avg_nm
    from {{ ref('cur_cytotox') }}
    union
    select distinct
        nanoparticle,
        normalized_shape,
        has_coating,
        np_size_avg_nm
    from {{ ref('cur_seltox') }}
    union
    select distinct
        nanoparticle,
        normalized_shape,
        has_coating,
        np_size_avg_nm
    from {{ ref('cur_synergy') }}
)

select
    *,
    {{ generate_canonical_name() }} as canonical_name,
    row_number() over (
        order by nanoparticle, normalized_shape, has_coating, np_size_avg_nm
    ) as nanoparticle_id
from unique_nanoparticles

