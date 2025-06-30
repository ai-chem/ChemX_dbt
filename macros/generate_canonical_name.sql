{% macro generate_canonical_name() %}
    concat(
        coalesce(nanoparticle, 'NULL'), '_',
        coalesce(normalized_shape, 'NULL'), '_',
        coalesce(cast(has_coating as text), 'NULL'), '_',
        coalesce(cast(np_size_avg_nm as text), 'NULL')
    )
{% endmacro %}