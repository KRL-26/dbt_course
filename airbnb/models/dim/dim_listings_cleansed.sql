---------------------------------------------
--Practica Dependencia de modelos y referencia
---------------------------------------------
--Especificamos que este modelo se materialice como view
--porque de default esta puesto que sea una tabla rn dbt_project.yml
{{
    config(
        materialized = 'view'
    )
}}

WITH src_listings AS(
    SELECT * FROM {{ref('src_listings')}} --Aqui hacemos referencia a otro modelo: src_listings
)
SELECT
    listing_id,
    listing_name,
    room_type,
    CASE WHEN minimum_nights = 0 THEN 1 ELSE minimum_nights END AS minimum_nights,
    host_id,
    REPLACE(price_str,'$') :: NUMBER (10,2) AS price,
    price_str,                                                                              --Price_usd: Ejemplo de cambio para comparar versiones entre prod vs dev
    created_at,
    updated_at
FROM src_listings