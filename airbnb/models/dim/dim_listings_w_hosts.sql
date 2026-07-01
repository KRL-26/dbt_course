---------------------------------------------
--Practica Materializacion con join de listings y hosts
---------------------------------------------
WITH 
listings AS (
    SELECT * FROM {{ref('dim_listings_cleansed')}}
),
hosts AS(
    SELECT * FROM {{ref('dim_hosts_cleansed', v = 2)}}
)
SELECT
    l.listing_id,
    l.listing_name,
    l.room_type,
    l.minimum_nights,
    l.price AS price,  
    l.price_str,                                     --Price_usd: Ejemplo de cambio para comparar versiones entre prod vs dev
    l.host_id,
    h.host_name,
    h.is_superhost AS host_is_superhost,
    l.created_at,
    GREATEST(l.updated_at, h.updated_at) as updated_at
FROM listings l
LEFT JOIN hosts h
    on (l.host_id = h.host_id)