
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
        md5(lower(trim(cast(ZIPCODE_HASH AS varchar)))) AS ZIPCODE_HASH,
        trim(ZIPCODE_NAME) AS ZIPCODE_NAME
    FROM zipcode_normalizado
    )

SELECT * FROM zipcode_casted

--stg_zipcodes (con ZIPCODE, STATE_ID)