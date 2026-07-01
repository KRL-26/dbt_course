---------------------------------------------
--Practica Materializacion Modelos
---------------------------------------------
--Creamos Modelo de hosts usando CTEs: la materializacion predeterminada del modelo es view en el esquema dev
WITH raw_hosts AS (
    SELECT * FROM {{source('airbnb','hosts')}}                      --referenciamos el source
)
SELECT
    id AS host_id,
    name AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM raw_hosts