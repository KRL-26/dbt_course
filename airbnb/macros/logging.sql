--Si no ponemos info=True, la funcion log() solo añade el comentario al .log file. En caso contrario lo muestra en la terminal
{% macro learn_logging() %}
    {{ log("Call your mom!") }}
    {{ log("Call your dad!", info=True) }} {# Logs to the screen, too #}
--  {{ log("Call your dad!", info=True) }} {# This will be logged to the screen #}
    {# log("Call your dad!", info=True) #} {# This won't be executed #}
{% endmacro %}