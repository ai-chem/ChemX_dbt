with nanoparticle_list as (
    select 'Ag'    as canonical_name, 1 as nanoparticle_id union all
    select 'Ag2O', 2 union all
    select 'AgO', 3 union all
    select 'Al2O3', 4 union all
    select 'Au', 5 union all
    select 'Bi', 6 union all
    select 'Bi2O3', 7 union all
    select 'C', 8 union all
    select 'CaHCO3', 9 union all
    select 'CdO', 10 union all
    select 'CeO2', 11 union all
    select 'Co', 12 union all
    select 'Co3O4', 13 union all
    select 'Cr', 14 union all
    select 'Cu', 15 union all
    select 'Cu2O', 16 union all
    select 'CuO', 17 union all
    select 'CuS', 18 union all
    select 'Fe2O3', 19 union all
    select 'Fe3O4', 20 union all
    select 'MgO', 21 union all
    select 'MnO', 22 union all
    select 'Mo', 23 union all
    select 'Ni', 24 union all
    select 'NiO', 25 union all
    select 'Pd', 26 union all
    select 'Pt', 27 union all
    select 'Se', 28 union all
    select 'SiO2', 29 union all
    select 'Ti', 30 union all
    select 'TiO2', 31 union all
    select 'ZnO', 32 union all
    select 'ZrO2', 33
)
select * from nanoparticle_list