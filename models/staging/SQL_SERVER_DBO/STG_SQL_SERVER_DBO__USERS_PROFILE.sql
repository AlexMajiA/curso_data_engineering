{{
  config(
    materialized='view'
  )
}}

WITH state_normalizado AS (
    SELECT * 
    FROM {{ ref('STG_SQL_SERVER_DBO__USERS') }}
),

profile_casted AS (
    SELECT 
        U.USER_ID,
        U.ADDRESS_ID ,
        U.LAST_NAME ,
        U.PHONE_NUMBER_CLEAN,
        U.FIRST_NAME ,
        U.EMAIL_CLEAN,
        U._FIVETRAN_DELETED ,
        U.FIVETRAN_SYNCED,
        A.ADDRESS_NAME,
        A.ZIPCODE_NAME,
        A.STATE_NAME,
        A.COUNTRY_NAME
    FROM {{ ref('STG_SQL_SERVER_DBO__USERS') }} U
    LEFT JOIN {{ source('SQL_SERVER_DBO', 'ADDRESSES') }} A
        ON A.ADDRESS_ID = U.ADDRESS_ID
)

SELECT * FROM profile_casted