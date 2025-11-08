{{
  config(
    materialized='view'
  )
}}

WITH FUENTE_PRINCIPAL AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'PROMOS') }}
    ),

promos_casted AS (
    SELECT
         md5(cast(PROMO_ID as varchar)) AS PROMO_ID,
         PROMO_ID AS PROMO_NAME,
	     CAST(DISCOUNT AS FLOAT) AS DISCOUNT,
	     STATUS,
	     _FIVETRAN_DELETED,
	     CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED
         FROM FUENTE_PRINCIPAL
         
    UNION ALL

    SELECT
    --Añado fila sin promo
        MD5('Sin_Promo') AS PROMO_ID,
        'Sin_Promo' AS PROMO_NAME,
        0 AS DISCOUNT,
        'Inactive' as STATUS,
        null AS _FIVETRAN_DELETED,
        CURRENT_TIMESTAMP AS DATE_LOAD

    )

SELECT * FROM promos_casted