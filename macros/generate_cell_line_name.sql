{% macro generate_cell_line_name(table_alias='') %}
    {% set prefix = table_alias ~ '.' if table_alias else '' %}
    concat(
        coalesce({{ prefix }}cell_type, 'NULL'), '_',
        coalesce({{ prefix }}human_animal, 'NULL'), '_',
        coalesce({{ prefix }}cell_source, 'NULL'), '_',
        coalesce({{ prefix }}cell_tissue, 'NULL'), '_',
        coalesce({{ prefix }}cell_morphology, 'NULL'), '_',
        coalesce(cast({{ prefix }}cell_age as text), 'NULL'), '_',
        coalesce(cast({{ prefix }}is_human as text), 'NULL')
    )
{% endmacro %}