
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
        md5(lower(trim(cast(ZIPCODE AS varchar)))) AS ZIPCODE_HASH, --siempre minuscula para que el hash sea el mismo.
        --trim(ZIPCODE) AS ZIPCODE_NAME,
        md5(lower(trim(COUNTRY))) AS COUNTRY_HASH,
        trim(COUNTRY) AS COUNTRY_NAME,
        md5(lower(trim(cast(ADDRESS AS varchar)))) AS ADDRESS_HASH,
        trim(ADDRESS) AS ADDRESS_NAME,
        md5(lower(trim(STATE))) AS STATE_HASH,
        trim(STATE) AS STATE_NAME,
        _FIVETRAN_DELETED,
        CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED
    FROM addresses_normalizada
    )

SELECT * FROM addresses_casted

