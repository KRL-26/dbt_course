-------------------------------------
--Practica Creacion Variable en macros
-------------------------------------
--Definimos el macro: learn_variables()
{% macro learn_variables() %}
    {# Esto la definicion de Jinja Variable #}
    {% set your_name_jinja = "Zoltan" %}
    {# Llamamos a la variable Jinja #}
    {{ log("Hello " ~ your_name_jinja, info=True) }}

    {# aqui llamamos a la variable dbt: nombre de la variable es user_name  y su valor de dafeult es NO USERNAME IS SET!!#}
    {{ log("Hello dbt user " ~ var("user_name", "NO USERNAME IS SET!!") ~ "!", info=True) }}

    {% if var("in_test", False) %}
       {{ log("In test", info=True) }}
    {% else %}
       {{ log("NOT in test", info=True) }}
    {% endif %}

{% endmacro %}