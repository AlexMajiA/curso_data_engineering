
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
    USER_ID ,
	UPDATED_AT ,
	ADDRESS_ID ,
	LAST_NAME ,
	CREATED_AT ,
	PHONE_NUMBER ,
	TOTAL_ORDERS ,
	FIRST_NAME ,
	EMAIL ,
	_FIVETRAN_DELETED ,
	CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED
    FROM src_budget
    )

SELECT * FROM renamed_casted