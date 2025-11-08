
{{
  config(
    materialized='view'
  )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'PRODUCTS') }}
    ),

renamed_casted AS (
    SELECT
     	PRODUCT_ID ,
	PRICE ,
	NAME ,
	INVENTORY ,
	_FIVETRAN_DELETED ,
	_FIVETRAN_SYNCED ,
    FROM src_budget
    )

SELECT * FROM renamed_casted