-- Справочник публикаций (dim_nanomag_publication).
-- Содержит уникальные публикации из nanomag и их основные атрибуты.
-- Используется для связи с факт-таблицей через publication_id.

{{ config(
    materialized='table',
    schema='star_schema',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (publication_id)"
) }}

select
    row_number() over (order by doi) as publication_id,
    doi,
    journal,
    publisher,
    year,
    title,
    pdf,
    access,
    access_bool
from (
    select distinct
        doi,
        journal,
        publisher,
        year,
        title,
        pdf,
        access,
        access_bool
    from {{ ref('final_cur_nanomag') }}
) t