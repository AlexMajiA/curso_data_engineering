
{{
  config(
    materialized='view'
  )
}}

WITH zipcode_normalizado AS (
    SELECT * 
    FROM {{ ref('STG_SQL_SERVER_DBO__ADDRESSES') }}
    ),

zipcode_casted AS (
    SELECT DISTINCT
        ADDRESS_ID,
        ZIPCODE_HASH,
        ADDRESS_NAME,
        STATE_NAME,
        COUNTRY_NAME
    FROM zipcode_normalizado
    )

SELECT * FROM zipcode_casted

