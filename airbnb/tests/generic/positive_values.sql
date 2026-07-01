-------------------------------------
--Practica Data Test: Custom Generic Tests
-------------------------------------
--Este custom generic test luego lo podemos llamar desde el yaml donde están los otros
--Generic test y contracts
--Definimos los parametros de nuestra funcion generica custom
--Definimos el test que comprobará. Si no devuelve nada ha pasado succesfully, sino tiene un failure
--Finalizamos la definicion del test
{% test positive_values (model, column_name) %}               
SELECT * FROM {{ model }} WHERE {{ column_name }} <= 0      
{% endtest %}                                                 