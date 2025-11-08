
{{
  config(
    materialized='view'
  )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'USERS') }}
    ),

renamed_casted AS (
    SELECT
        USER_ID,
        CONVERT_TIMEZONE('Europe/Madrid', UPDATED_AT::TIMESTAMP_NTZ) AS UPDATED_AT,
        ADDRESS_ID ,
        LAST_NAME ,
        CONVERT_TIMEZONE('Europe/Madrid', CREATED_AT::TIMESTAMP_NTZ) AS CREATED_AT,
        REGEXP_REPLACE(PHONE_NUMBER, '[^0-9]', '') AS PHONE_NUMBER_CLEAN
        TOTAL_ORDERS ,
        FIRST_NAME ,
        EMAIL ,
        _FIVETRAN_DELETED ,
        CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED
    FROM src_budget
    )

SELECT * FROM renamed_casted