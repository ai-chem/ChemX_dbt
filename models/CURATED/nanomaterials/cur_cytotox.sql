-- models/curated/nanomaterials/cur_cytotox.sql
{{ config(
    materialized='view',
    schema='curated'
) }}

-- Используем макрос для дедубликации
{{ deduplicate_model('uni_cytotox') }}