-- models/curated/nanomaterials/cur_co_crystals.sql
{{ config(
    materialized='view',
    schema='curated'
) }}

-- Используем макрос для дедубликации
{{ deduplicate_model('uni_co_crystals') }}