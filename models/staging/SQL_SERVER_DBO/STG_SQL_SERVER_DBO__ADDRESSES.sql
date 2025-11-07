
{{
  config(
    materialized='view'
  )
}}

WITH addresses_normalizada AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'ADDRESSES') }}
    ),

addresses_casted AS (
    SELECT
        ADDRESS_ID,
        md5(cast(ADDRESS AS varchar)) AS ADDRESS,
        _FIVETRAN_DELETED ,
        CONVERT_TIMEZONE('UTC', _FIVETRAN_SYNCED)
    FROM addresses_normalizada
    )

SELECT * FROM addresses_casted