---------------------------------------------
--Practica Dependencia de modelos y referencia
---------------------------------------------
--Especificamos que este modelo se materialice como view
--porque de default esta puesto que sea una tabla rn dbt_project.yml
{#
  You might have `view` as the materialization as we only 
  replace `materialized` with `table` when we implement constraints. 
#}
{{
  config(
    materialized = 'table' 
    )
}} 

WITH src_hosts AS (
    SELECT * FROM {{ref('src_hosts')}}      --Aqui hacemos referencia a otro modelo: src_hosts
)
SELECT 
    host_id,
    NVL(host_name,'N/A') AS host_name,
    is_superhost,
    created_at,
    updated_at 
FROM src_hosts