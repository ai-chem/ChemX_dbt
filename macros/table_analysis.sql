{% macro get_rows_without_nulls(source_name, table_name) %}
SELECT *
FROM {{ source(source_name, table_name) }}
WHERE {% for column in adapter.get_columns_in_relation(source(source_name, table_name)) %}
    {{ column.name }} IS NOT NULL
    {% if not loop.last %} AND {% endif %}
{% endfor %}
{% endmacro %}

--_________________________________

{% macro get_first_n_columns(source_name, table_name, n=5) %}
SELECT
    {% for column in adapter.get_columns_in_relation(source(source_name, table_name)) %}
        {% if loop.index <= n %}
            {{ column.name }}{% if not loop.last and loop.index < n %},{% endif %}
        {% endif %}
    {% endfor %}
FROM {{ source(source_name, table_name) }}
{% endmacro %}

--_________________________________

{% macro get_null_counts(source_name, table_name) %}
SELECT
    {% for column in adapter.get_columns_in_relation(source(source_name, table_name)) %}
        SUM(CASE WHEN {{ column.name }} IS NULL THEN 1 ELSE 0 END) as {{ column.name }}_null_count{% if not loop.last %},{% endif %}
    {% endfor %}
FROM {{ source(source_name, table_name) }}
{% endmacro %}

--_________________________________

{% macro column_stats(source_name, table_name) %}
WITH base_counts AS (
    SELECT
        COUNT(*) AS total_rows
    FROM
        {{ source(source_name, table_name) }}
)

{% for column in adapter.get_columns_in_relation(source(source_name, table_name)) %}
SELECT
    '{{ column.name }}' AS column_name,
    '{{ column.data_type }}' AS data_type,
    base_counts.total_rows AS total_rows,
    SUM(CASE WHEN {{ column.name }} IS NULL THEN 1 ELSE 0 END) AS null_count,
    ROUND(100.0 * SUM(CASE WHEN {{ column.name }} IS NULL THEN 1 ELSE 0 END) / base_counts.total_rows, 2) AS null_percentage
FROM
    {{ source(source_name, table_name) }},
    base_counts
GROUP BY
    base_counts.total_rows

{% if not loop.last %}
UNION ALL
{% endif %}
{% endfor %}
ORDER BY
    null_percentage DESC,
    column_name
{% endmacro %}