{% macro create_has_coating_column(coating_column, column_type='text') %}

{% if column_type == 'bigint' %}
CASE
    WHEN {{ coating_column }} = 0 THEN 0
    WHEN {{ coating_column }} = 1 THEN 1
    WHEN {{ coating_column }} IS NULL THEN 0
    ELSE 1
END AS has_coating
{% else %}
CASE
    WHEN {{ coating_column }} IS NULL THEN 0
    WHEN TRIM({{ coating_column }}) = '' THEN 0
    WHEN {{ coating_column }}::text = 'null' THEN 0
    ELSE 1
END AS has_coating
{% endif %}

{% endmacro %}