-- models/curated/nanomaterials/cur_synergy.sql
{{ config(
    materialized='view',
    schema='curated'
) }}

-- Используем макрос для дедубликации
{{ deduplicate_model('uni_synergy') }}