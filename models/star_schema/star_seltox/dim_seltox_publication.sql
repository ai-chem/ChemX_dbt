-- Справочник публикаций.
-- Содержит уникальные публикации из seltox и их основные атрибуты.
-- Используется для связи с факт-таблицей через publication_id.

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
    access
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
        access
    from {{ ref('final_cur_seltox') }}
) t