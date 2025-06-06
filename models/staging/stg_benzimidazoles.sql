-- models/staging/stg_benzimidazoles.sql
{{ config(materialized='view') }}

SELECT * FROM {{ source('raw', 'benzimidazoles') }}