-- Справочник публикаций (dim_synergy_publication).
-- Содержит уникальные публикации из synergy и их основные атрибуты.

{{ config(
    materialized='table',
    schema='star_schema',
    post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (publication_id)"
) }}

select
    row_number() over (order by doi) as publication_id,
    doi,
    article_list,
    journal_name,
    publisher,
    year,
    title,
    journal_is_oa,
    is_oa,
    oa_status,
    pdf,
    access,
    access_bool
from (
    select distinct
        doi,
        article_list,
        journal_name,
        publisher,
        year,
        title,
        journal_is_oa,
        is_oa,
        oa_status,
        pdf,
        access,
        access_bool
    from {{ ref('final_cur_synergy') }}
) t