{{
  config(
    materialized='view'
  )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'PROMOS') }}
    ),

promos_casted AS (
    SELECT
          md5(PROMO_ID) AS PROMO_ID
         , PROMO_ID AS PROMO_NAME
	     , DISCOUNT
	     , STATUS
	     , _FIVETRAN_DELETED
	     , _FIVETRAN_SYNCED
         , _fivetran_synced AS date_load
    FROM src_budget
    UNION ALL
        SELECT
        
    )
    

    

SELECT * FROM promos_casted