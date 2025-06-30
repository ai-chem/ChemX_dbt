-- Справочник публикаций (dim_publication).
-- Содержит уникальные публикации, встречающиеся в данных, и их основные атрибуты (DOI, журнал, год, доступность и др.).
-- Используется для связи с факт-таблицей через publication_id.
{{ config(
    materialized='table',
    schema='star_schema'
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
    from {{ ref('final_cur_cytotox') }}
) t