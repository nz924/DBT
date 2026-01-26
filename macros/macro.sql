{% macro age_group(age_column) %}
    CASE
        WHEN {{ age_column }} >= 18 THEN 'Adult'
        ELSE 'Child'
    END
{% endmacro %}
