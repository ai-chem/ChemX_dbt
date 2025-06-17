-- models/curated/nanomaterials/cur_seltox.sql
{{ config(
    materialized='view',
    schema='curated'
) }}

-- Используем макрос для дедубликации
{{ deduplicate_model('uni_seltox') }}