with all_nanoparticles as (
    select
        nanoparticle,
        normalized_shape,
        has_coating,
        np_size_avg_nm
    from dbt_curated.cur_cytotox
    union all
    select
        nanoparticle,
        normalized_shape,
        has_coating,
        np_size_avg_nm
    from dbt_curated.cur_seltox
    union all
    select
        nanoparticle,
        normalized_shape,
        has_coating,
        np_size_avg_nm
    from dbt_curated.cur_synergy
)
select
    nanoparticle,
    normalized_shape,
    has_coating,
    np_size_avg_nm,
    count(*) as total_count
from all_nanoparticles
group by
    nanoparticle,
    normalized_shape,
    has_coating,
    np_size_avg_nm
having count(*) > 1