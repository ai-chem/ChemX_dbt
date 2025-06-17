-- models/curated/nanomaterials/cur_benzimidazoles.sql
{{ config(
    materialized='view',
    schema='curated'
) }}

-- Используем макрос для дедубликации
{{ deduplicate_model('uni_benzimidazoles') }}