
{{
  config(
    materialized='view'
  )
}}

WITH users_source AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'USERS') }}
    ),

users_cleaned AS (
    SELECT
        USER_ID,
        CONVERT_TIMEZONE('Europe/Madrid', UPDATED_AT::TIMESTAMP_NTZ) AS UPDATED_AT,
        ADDRESS_ID ,
        INITCAP(trim(LAST_NAME)) AS LAST_NAME_CLEAN,
        CONVERT_TIMEZONE('Europe/Madrid', CREATED_AT::TIMESTAMP_NTZ) AS CREATED_AT,
        REGEXP_REPLACE(PHONE_NUMBER, '[^0-9]', '') AS PHONE_NUMBER_CLEAN,
        --TOTAL_ORDERS , no lo incluyo porque será calculado en gold.
        INITCAP(trim(FIRST_NAME)) AS FIRST_NAME_CLEAN, --Primera en mayuscula, resto minuscula.

        md5(lower(trim(EMAIL))) AS EMAIL_HASH,
        lower(trim(EMAIL)) AS EMAIL_CLEAN ,

        coalesce(_FIVETRAN_DELETED, false) as Is_deleted, --Marco si un registro fue eliminado en origen.
        CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED
    FROM users_source
    )

SELECT * FROM users_cleaned

--COALESCE(Devuelve el primer valor no nulo)