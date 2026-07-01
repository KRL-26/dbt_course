---------------------------------------------
--Practica Materializacion como tabla Incremental de un modelo
---------------------------------------------
--Definimos la configuracion de la materizacion de este modelo mediante template tag de JINJA
--materialized: Indicamos que la materializacion sera tipo incremental
--on_schema_change: Indicamos que pasa si el esquema de la tabla de donde leemos cambia
--Como estamos trabajando con microbatchs en "mart_fullmoon_reviews", definimos el event_time aqui tambien
{{
    config(
        materialized = 'incremental',   
        event_time = 'review_date',    
        on_schema_change = 'fail'           
    )
}}

WITH src_reviews AS (
    SELECT * FROM {{ref('src_reviews')}}     --Hacemos referencia al modelo de src_reviews
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} AS review_id, 
    *
FROM src_reviews
    WHERE review_text IS NOT NULL

--JINJA if statement: Si es una materializacion incremental hará el codigo SQL
--version Pro
--En caso de pasarle las variables dbt "start_date" y "end_date" hace la carga de las fechas indicadas
--En caso de no pasarle las variables dbt "start_date" y "end_date" hace la carga de las fechas que no estén en la tabla
--Añadimos var("nombre_variable", False) en las clausulas if para tratar los casos donde no se define la variable. Es obligatorio
{% if is_incremental() %}
  {% if var("start_date", False) and var("end_date", False) %}
    {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
    AND review_date >= '{{ var("start_date") }}'
    AND review_date < '{{ var("end_date") }}'
  {% else %}
    AND review_date > (select max(review_date) from {{ this }})
    {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}}
  {% endif %}
{% endif %}       

--JINJA if statement: Si es una materializacion incremental hará el codigo SQL
--Version normal
--{% if is_incremental() %}                                             --Inicio IF
--    AND review_date > (SELECT max(review_date) from {{ this }})       --Decimos qué nuevos regstros queremos traernos
--{% endif %}                                                           --FIN IF
                                                                        -- this: hace referencia a este modelo: fact_reviews
                                                                        -- si queremos reconstruir cualquier tabla incremental: dbt run --full-refresh
                                                             