{{ config(
    materialized='table',
    schema='star_schema'
) }}

select
    nanoparticle_list.nanoparticle_id,
    nanoparticle_list.nanoparticle,
    nanoparticle_list.normalized_shape,
    nanoparticle_list.has_coating,
    nanoparticle_list.np_size_avg_nm,
    nanoparticle_list.canonical_name,
    -- Дополнительные характеристики из final_cur_cytotox
    final_cur_cytotox.coat_functional_group,
    final_cur_cytotox.standardized_synthesis_method,
    final_cur_cytotox.is_surface_positive,
    final_cur_cytotox.potential_mv,
    final_cur_cytotox.hydrodynamic_nm,
    final_cur_cytotox.core_nm,
    final_cur_cytotox.zeta_potential_mv,
    final_cur_cytotox.size_in_medium_nm,
    final_cur_cytotox.surface_charge,
    final_cur_cytotox.synthesis_method
from {{ ref('nanoparticle_list') }} nanoparticle_list
left join {{ ref('final_cur_cytotox') }} final_cur_cytotox
    on nanoparticle_list.nanoparticle = final_cur_cytotox.nanoparticle
    and nanoparticle_list.normalized_shape = final_cur_cytotox.normalized_shape
    and nanoparticle_list.has_coating = final_cur_cytotox.has_coating
    and nanoparticle_list.np_size_avg_nm = final_cur_cytotox.np_size_avg_nm