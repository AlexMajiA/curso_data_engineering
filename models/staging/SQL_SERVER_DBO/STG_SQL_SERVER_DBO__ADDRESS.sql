
{{
  config(
    materialized='view'
  )
}}

WITH address_normalizado AS (
    SELECT * 
    FROM {{ ref('STG_SQL_SERVER_DBO__ADDRESSES') }} 
    ),

address_casted AS (
    SELECT DISTINCT
        md5(lower(trim(cast(ADDRESS_HASH AS varchar)))) AS ADDRESS_HASH,
        trim(ADDRESS_NAME) AS ADDRESS_NAME
        FROM address_normalizado
    )

SELECT * FROM address_casted