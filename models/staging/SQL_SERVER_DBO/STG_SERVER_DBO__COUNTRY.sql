{{
  config(
    materialized='view'
  )
}}

WITH country_normalizado AS (
    SELECT * 
    FROM {{ ref('STG_SQL_SERVER_DBO__ADDRESSES') }}
),

country_casted AS (
    SELECT DISTINCT
           md5(lower(trim(COUNTRY_HASH))) AS COUNTRY_HASH,
           trim(COUNTRY_NAME) AS COUNTRY_NAME
    FROM country_normalizado
)

SELECT * FROM country_casted


--stg_countries (con COUNTRY_NAME)