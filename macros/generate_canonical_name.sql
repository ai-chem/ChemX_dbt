{% macro generate_canonical_name() %}
    concat(nanoparticle, '_', normalized_shape, '_', has_coating, '_', np_size_avg_nm)
{% endmacro %}