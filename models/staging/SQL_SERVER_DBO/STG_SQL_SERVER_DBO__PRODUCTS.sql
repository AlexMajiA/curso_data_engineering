
{{
  config(
    materialized='view'
  )
}}

WITH products_normalizado AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'PRODUCTS') }}
    ),

products_casted AS (
    SELECT
        PRODUCT_ID ,
        cast(PRICE AS decimal (10,2)) AS PRICE ,
        md5(lower(trim(NAME))) AS NAME_HASH,
        trim(NAME) AS NAME,
        INVENTORY ,
        _FIVETRAN_DELETED ,
        CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED
    FROM products_normalizado
    )

SELECT * FROM products_casted