---------------------------------------------
--Practica Materializacion Modelos
---------------------------------------------
--Creamos Modelo de listings usando CTEs: la materializacion predeterminada del modelo es view en el esquema dev
WITH raw_listings as (
    SELECT * FROM {{source('airbnb','listings')}}                   --referenciamos el source
)
SELECT
    id AS listing_id,
    name AS listing_name,
    listing_url,
    room_type,
    minimum_nights,
    host_id,
    price AS price_str,
    created_at,
    updated_at
FROM raw_listings