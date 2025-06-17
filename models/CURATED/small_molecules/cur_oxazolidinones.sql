-- models/curated/nanomaterials/cur_oxazolidinones.sql
{{ config(
    materialized='view',
    schema='curated'
) }}

-- Используем макрос для дедубликации
{{ deduplicate_model('uni_oxazolidinones') }}