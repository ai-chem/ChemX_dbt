-- models/curated/nanomaterials/cur_nanozymes.sql
{{ config(
    materialized='view',
    schema='curated'
) }}

-- Используем макрос для дедубликации
{{ deduplicate_model('uni_nanozymes') }}