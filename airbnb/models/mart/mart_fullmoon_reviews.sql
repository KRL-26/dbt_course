---------------------------------------------
--Practica Materializacion Modelo Capa Mart
---------------------------------------------
--Mart: es la capa que usualmente coniene las tablas y vistas a las que se accede desde herramientas BI
--Atribuimos especificaente a este modelo el tag de fact
--Configuramos la tabla temporal que funciona con estrategia de microbatching
--Para micribatching tenemos que definir 3 parametros:
--Event_time : es el evento que se usara para saber de cuando en cuando traer datos
--Begin : Desde cuando queremos los datos
--Batch Size: Cantidad de datos per Batch. En este caso vamos año por año
--Excluimos esta tabla de full refresh con full_refresh = false
--De todos modos podemos ejecutar un full refresh de la tabla indicando el rango con: 
-- dbt run -s mart_fullmoon_reviews --full-refresh --event-time-start "2020-01-01" --event-time-end "2030-01-01"
{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'microbatch',
        event_time = 'review_date',
        begin = '2009-06-20',
        batch_size = 'year' ,
        full_refresh = false,
        tags = ['fact'],
        schema = 'mart'
    )
}}

WITH 
fct_reviews AS (
    SELECT * FROM {{ref('fact_reviews')}}
),
full_moon_dates AS(
    SELECT * FROM {{ref('seed_full_moon_dates')}}
)
SELECT a.*,
    CASE WHEN b.full_moon_date IS NULL THEN 'not full moon' ELSE 'full moon' END AS is_full_moon

FROM fct_reviews a
LEFT JOIN full_moon_dates b
    on (TO_DATE(a.review_date) = DATEADD(DAY,1,b.full_moon_date))
