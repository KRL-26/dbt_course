-------------------------------------
--Practica Data Test: Custom Generic Tests
-------------------------------------
--Este custom generic test luego lo podemos llamar desde el yaml donde están los otros
--Generic test y contracts
--Definimos nombre y los parametros de nuestra funcion generica custom
--Indicamos que tipo de error da si es un failure. En este caso predefinimos a que sea un warning
--Definimos el test que comprobará. Si no devuelve nada ha pasado succesfully, sino tiene un failure
--Finalizamos la definicion del test
{% test minimum_row_count(model, min_row_count) %}
{{ config(
    severity = 'warn'
)}}
SELECT COUNT (*) as cnt FROM {{ model }}
HAVING COUNT (*) < {{ min_row_count  }}
{% endtest %}