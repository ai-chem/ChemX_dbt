-- models/curated/nanomaterials/cur_nanomag.sql
{{ config(
    materialized='view',
    schema='curated'
) }}

-- Используем макрос для дедубликации
{{ deduplicate_model('uni_nanomag') }}