{% macro age_group(age_column) %}
    CASE
        WHEN {{ age_column }} >= 18 THEN 'Adult'
        ELSE 'Child'
    END
{% endmacro %}


{% macro generate_surrogate_key(columns) %}
    md5(
        concat(
            {% for col in columns %}
                coalesce(cast({{ col }} as varchar), '')
                {% if not loop.last %}, '|' ,{% endif %}
            {% endfor %}
        )
    )
{% endmacro %}



-- macros/allowed_values.sql
{% macro allowed_values(column, values) %}
    {{ column }} IN (
        {% for v in values %}
            '{{ v }}'{% if not loop.last %}, {% endif %}
        {% endfor %}
    )
{% endmacro %}

