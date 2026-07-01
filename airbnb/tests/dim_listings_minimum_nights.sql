-------------------------------------
--Practica Data Test: Singular Tests
-------------------------------------
--Singular test: are SQL queries taht should give an empty result if it pases
--If it doesn't pass, then it should give the failures values
SELECT * FROM {{ ref('dim_listings_cleansed') }}
WHERE minimum_nights < 1
LIMIT 10