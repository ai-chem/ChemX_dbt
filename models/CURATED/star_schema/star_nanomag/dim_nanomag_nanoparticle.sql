-- Справочник наночастиц (dim_nanomag_nanoparticle).
-- Каждая строка — уникальная наночастица, определяемая по составу, оболочкам, пространственным группам и размеру.
-- Используется для связи с факт-таблицей через nanoparticle_id.

{{ config(
    materialized='table',
    schema='star_schema',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (nanoparticle_id)"
) }}

with unique_nanoparticles as (
    select distinct
        nanoparticle,
        np_shell,
        np_shell_2,
        space_group_core,
        space_group_shell,
        xrd_scherrer_size
    from {{ ref('final_cur_nanomag') }}
)

, first_row as (
    select
        *,
        row_number() over (
            partition by nanoparticle, np_shell, np_shell_2, space_group_core, space_group_shell, xrd_scherrer_size
            order by id
        ) as row_num_in_group
    from {{ ref('final_cur_nanomag') }}
)

select
    -- surrogate key
    row_number() over (
        order by
            unique_nanoparticles.nanoparticle,
            unique_nanoparticles.np_shell,
            unique_nanoparticles.np_shell_2,
            unique_nanoparticles.space_group_core,
            unique_nanoparticles.space_group_shell,
            unique_nanoparticles.xrd_scherrer_size
    ) as nanoparticle_id,

    -- ключевые поля
    unique_nanoparticles.nanoparticle,
    unique_nanoparticles.np_shell,
    unique_nanoparticles.np_shell_2,
    unique_nanoparticles.space_group_core,
    unique_nanoparticles.space_group_shell,
    unique_nanoparticles.xrd_scherrer_size,

    -- дополнительные характеристики
    first_row.core_shell_formula,
    first_row.np_hydro_size,
    first_row.emic_size,
    first_row.instrument

from unique_nanoparticles
left join first_row
    on unique_nanoparticles.nanoparticle = first_row.nanoparticle
    and unique_nanoparticles.np_shell = first_row.np_shell
    and unique_nanoparticles.np_shell_2 = first_row.np_shell_2
    and unique_nanoparticles.space_group_core = first_row.space_group_core
    and unique_nanoparticles.space_group_shell = first_row.space_group_shell
    and unique_nanoparticles.xrd_scherrer_size = first_row.xrd_scherrer_size
    and first_row.row_num_in_group = 1