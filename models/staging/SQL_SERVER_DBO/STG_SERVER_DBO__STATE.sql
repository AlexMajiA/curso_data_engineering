{{
  config(
    materialized='view'
  )
}}

WITH state_normalizado AS (
    SELECT * 
    FROM {{ ref('STG_SQL_SERVER_DBO__ADDRESSES') }}
),

state_casted AS (
    SELECT DISTINCT
           md5(lower(trim(STATE_HASH))) AS STATE_HASH,
           trim(STATE_NAME) AS COUNTRY_NAME
    FROM state_normalizado
)

SELECT * FROM state_casted



--stg_states (con STATE_NAME, COUNTRY_ID)

