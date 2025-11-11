
{{
  config(
    materialized='view'
  )
}}

WITH addresses_source AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'ADDRESSES') }}
    ),

addresses_cleaned AS (
    SELECT
        ADDRESS_ID,

        md5(lower(trim(cast(ZIPCODE AS varchar)))) AS ZIPCODE_HASH, 
        cast(ZIPCODE AS number) AS ZIPCODE_CLEAN,


        md5(lower(trim(COUNTRY))) AS COUNTRY_HASH,
        upper(trim(COUNTRY)) AS COUNTRY_NAME,

        md5(lower(trim(cast(ADDRESS AS varchar)))) AS ADDRESS_HASH,
        trim(ADDRESS) AS ADDRESS_NAME,

        md5(lower(trim(STATE))) AS STATE_HASH,
        upper(trim(STATE)) AS STATE_NAME,

        coalesce(_FIVETRAN_DELETED, false) as Is_deleted, --Marco si un registro fue eliminado en origen.
        CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED

    FROM addresses_source
    )

SELECT * FROM addresses_cleaned

