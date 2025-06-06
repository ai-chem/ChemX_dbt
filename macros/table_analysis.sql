{% macro get_rows_without_nulls(source_name, table_name) %}
SELECT *
FROM {{ source(source_name, table_name) }}
WHERE {% for column in adapter.get_columns_in_relation(source(source_name, table_name)) %}
    {{ column.name }} IS NOT NULL
    {% if not loop.last %} AND {% endif %}
{% endfor %}
{% endmacro %}

{% macro get_first_n_columns(source_name, table_name, n=5) %}
SELECT
    {% for column in adapter.get_columns_in_relation(source(source_name, table_name)) %}
        {% if loop.index <= n %}
            {{ column.name }}{% if not loop.last and loop.index < n %},{% endif %}
        {% endif %}
    {% endfor %}
FROM {{ source(source_name, table_name) }}
{% endmacro %}

{% macro get_null_counts(source_name, table_name) %}
SELECT
    {% for column in adapter.get_columns_in_relation(source(source_name, table_name)) %}
        SUM(CASE WHEN {{ column.name }} IS NULL THEN 1 ELSE 0 END) as {{ column.name }}_null_count{% if not loop.last %},{% endif %}
    {% endfor %}
FROM {{ source(source_name, table_name) }}
{% endmacro %}