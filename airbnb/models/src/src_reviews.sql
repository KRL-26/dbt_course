---------------------------------------------
--Practica Materializacion Modelos
---------------------------------------------
--Creamos Modelo de hosts usando CTEs: la materializacion predeterminada del modelo es view en el esquema dev
WITH raw_reviews AS (
    SELECT * FROM {{source('airbnb','reviews')}}             --referenciamos el source
)
SELECT
    listing_id,
    date as review_date,
    reviewer_name,
    comments as review_text,
    sentiment as review_sentiment
FROM raw_reviews