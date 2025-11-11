
{{
  config(
    materialized='view'
  )
}}

WITH events_normalizado AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'EVENTS') }}
    ),

events_casted AS (
    SELECT
     	EVENT_ID ,
        PAGE_URL ,
        EVENT_TYPE ,
        USER_ID ,
        PRODUCT_ID ,
        SESSION_ID ,
        CREATED_AT ,
        ORDER_ID ,
        _FIVETRAN_DELETED ,
        CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED
    FROM events_normalizado
    )

SELECT * FROM events_casted