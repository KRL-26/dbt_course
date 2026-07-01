-------------------------------------
--Practica Creacion Macro JINJA
-------------------------------------
--adapter.get_columns_in_relation(model): obtiene todas las columnas del objeto modelo
{% macro no_empty_strings(model) %}
    {%- for col in adapter.get_columns_in_relation(model) -%}
        {%- if col.is_string() %}
            {{ col.name }} IS NOT NULL AND {{ col.name }} <> '' AND 
        {%- endif %}
    {%- endfor %}
    TRUE
{% endmacro %}